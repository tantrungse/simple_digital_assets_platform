module Creator
  class AssetImportService
    MAX_FILE_SIZE = 5.megabytes
    ALLOWED_CONTENT_TYPES = ['application/json', 'text/json'].freeze

    class Result
      attr_reader :imported_count, :error_message

      def initialize(success:, imported_count: 0, error_message: nil)
        @success = success
        @imported_count = imported_count
        @error_message = error_message
      end

      def success?
        @success
      end
    end

    def initialize(user, file)
      @user = user
      @file = file
    end

    def call
      validate_file!
      data = parse_file
      import_assets(data)
    rescue => e
      Result.new(success: false, error_message: e.message)
    end

    private

    def validate_file!
      if @file.size > MAX_FILE_SIZE
        raise "File is too large (max #{MAX_FILE_SIZE.to_s(:human_size)})"
      end

      unless ALLOWED_CONTENT_TYPES.include?(@file.content_type)
        raise "Invalid file type. Please upload a JSON file."
      end
    end

    def parse_file
      JSON.parse(@file.read)
    rescue JSON::ParserError
      raise "Invalid JSON file format."
    end

    def import_assets(data)
      return Result.new(success: true, imported_count: 0) if data.empty?

      imported_count = 0
      ActiveRecord::Base.transaction do
        data.each do |attrs|
          asset = @user.assets.new(
            title: attrs["title"],
            description: attrs["description"],
            file_url: attrs["file_url"],
            price: attrs["price"]
          )
          asset.save!
          imported_count += 1
        end
      end

      Result.new(success: true, imported_count: imported_count)
    rescue ActiveRecord::RecordInvalid => e
      raise "Validation failed: #{e.record.errors.full_messages.join(', ')}"
    end
  end
end
