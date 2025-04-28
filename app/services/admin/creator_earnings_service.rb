module Admin
  class CreatorEarningsService
    def initialize(scope = User.creator)
      @scope = scope
    end

    def call
      creators = @scope
        .left_joins(assets: :purchases)
        .group('users.id')
        .select('users.id AS creator_id, COALESCE(SUM(CASE WHEN purchases.id IS NOT NULL THEN assets.price ELSE 0 END), 0) AS total_earnings')

      creators.map do |creator|
        {
          creator_id: creator.creator_id,
          total_earnings: creator.total_earnings.to_f
        }
      end
    end
  end
end
