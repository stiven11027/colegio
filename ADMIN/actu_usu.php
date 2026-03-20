<?php

include '../ASSETS/conexion.php';

if(!isset($_POST['documento'])) die('Documento no especificado');

$id = intval($_POST['documento']);
$nombres = mysqli_real_escape_string($conexion, trim($_POST['up_nombres']));
$apellidos = mysqli_real_escape_string($conexion, trim($_POST['up_apellidos'] ?? ''));
$email = mysqli_real_escape_string($conexion, trim($_POST['up_email'] ?? ''));
$id_rol = intval($_POST['up_rol'] ?? 3);
$estado = mysqli_real_escape_string($conexion, $_POST['up_estado'] ?? 'Activo');
$pas = !empty($_POST['up_pass']) ? mysqli_real_escape_string($conexion, $_POST['up_pass']) : '';

// Si la contraseña está vacía, mantener la actual
if(empty($pas)) {
    $update = "UPDATE usuario SET nombres='$nombres', apellidos='$apellidos', email='$email', id_rol=$id_rol, estado='$estado' WHERE ID=$id";
} else {
    $update = "UPDATE usuario SET nombres='$nombres', apellidos='$apellidos', email='$email', id_rol=$id_rol, estado='$estado', pass='$pas' WHERE ID=$id";
}
$exe_update = mysqli_query($conexion, $update);
if(!$exe_update)
{
    echo "Error al actualizar el usuario";
    echo "<a href='usuarios.php'><input type='button' value='Regresar'></a>";
}
else
{
    header('Location: usuarios.php');
}

?>