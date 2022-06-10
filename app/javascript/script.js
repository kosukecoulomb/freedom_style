window.addEventListener('turbolinks:load', () => {
    const uploader = document.querySelector('.uploader');
    uploader.addEventListener('change', (e) => {
      const file = uploader.files[0];
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => {
        const coordinate_image = reader.result;
        document.querySelector('.avatar').setAttribute('src', coordinate_image);
      }
    });
});

window.addEventListener('turbolinks:load', () => {
    const uploader = document.querySelector('.uploader');
    uploader.addEventListener('change', (e) => {
      const file = uploader.files[0];
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => {
        const item_image = reader.result;
        document.querySelector('.item').setAttribute('src', item_image);
      }
    });
});
