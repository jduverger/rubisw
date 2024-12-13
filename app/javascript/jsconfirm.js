document.addEventListener('DOMContentLoaded', () => {
    document.addEventListener('submit', (event) => {
      const form = event.target;
      if (form.dataset.confirm) {
        if (!confirm(form.dataset.confirm)) {
          event.preventDefault();
          return false;
        }
      }
    });
  });