<?php
session_start();
include 'ASSETS/conexion.php';

if(!isset($_POST['doc'], $_POST['pass'])) {
    $_SESSION['msg'] = "Faltan datos requeridos";
    header('Location: index.php');
    die;
}

$doc = intval($_POST['doc']);
$pass = mysqli_real_escape_string($conexion, $_POST['pass']);

// Buscar usuario por ID en la base de datos
$consulta = "SELECT * FROM usuario WHERE ID = $doc";
$resultado = mysqli_query($conexion, $consulta);

if(!$resultado) {
    $_SESSION['msg'] = "Error en la base de datos";
    header('Location: index.php');
    die;
}

$datos = mysqli_fetch_assoc($resultado);

if ($datos) {
    // Usuario existe, validar contraseña
    if ($datos['pass'] == $pass && $datos['estado'] == 'Activo') {
        // Contraseña correcta y usuario activo
        $_SESSION['doc'] = $datos['ID'];
        $_SESSION['documento'] = $datos['ID'];
        $_SESSION['user_id'] = $datos['ID'];
        $_SESSION['usuario'] = $datos['nombres'];
        $_SESSION['id_rol'] = $datos['id_rol'];
        $_SESSION['email'] = $datos['email'];
        
        header('Location: ADMIN/usuarios.php');
    } else if ($datos['estado'] != 'Activo') {
        // Usuario inactivo
        $_SESSION['msg'] = "Usuario inactivo. Contacte al administrador";
        header('Location: index.php');
    } else {
        // Contraseña incorrecta
        $_SESSION['msg'] = "Contraseña incorrecta";
        header('Location: index.php');
    }
} else {
    // Usuario no existe
    $_SESSION['msg'] = "Usuario no encontrado";
    header('Location: index.php');
}
?>
