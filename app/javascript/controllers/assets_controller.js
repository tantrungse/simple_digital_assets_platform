import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const fileInput = document.getElementById('json_file_input')
    const uploadButton = document.getElementById('upload_button')

    if (fileInput && uploadButton) {
      fileInput.addEventListener('change', (event) => {
        const file = event.target.files[0]
        
        if (file && file.name.endsWith('.json')) {
          uploadButton.disabled = false
        } else {
          uploadButton.disabled = true
          alert('Please select a valid .json file!')
        }
      })
    }
  }
}