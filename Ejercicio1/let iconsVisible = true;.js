let iconsVisible = true;

function toggleIcons() {
  // Seleccionar los íconos
  const prevIcon = document.querySelector('.carousel-control-prev-icon');
  const nextIcon = document.querySelector('.carousel-control-next-icon');

  // Verificar si los íconos están visibles o no
  if (iconsVisible) {
    // Ocultar los íconos
    prevIcon.style.display = 'none';
    nextIcon.style.display = 'none';
  } else {
    // Mostrar los íconos
    prevIcon.style.display = 'block';
    nextIcon.style.display = 'block';
  }

  // Alternar el estado de visibilidad
  iconsVisible = !iconsVisible;
}

// Asignar la función al evento de clic
document.addEventListener('click', toggleIcons);