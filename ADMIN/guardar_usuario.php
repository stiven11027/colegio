<?php
include '../ASSETS/conexion.php';

if(!isset($_POST['id'], $_POST['nombres'], $_POST['pass'])) {
    die('Faltan datos requeridos');
}

$id = intval($_POST['id']);
$nombres = mysqli_real_escape_string($conexion, trim($_POST['nombres']));
$apellidos = mysqli_real_escape_string($conexion, trim($_POST['apellidos'] ?? ''));
$email = mysqli_real_escape_string($conexion, trim($_POST['email'] ?? ''));
$id_rol = intval($_POST['id_rol']);
$pas = mysqli_real_escape_string($conexion, $_POST['pass']);
$estado = mysqli_real_escape_string($conexion, $_POST['estado'] ?? 'Activo');

//confirmar que el usuario no está registrado
$consul_usu = "SELECT * from usuario where ID = '$id'";
$exe_consul = mysqli_query($conexion, $consul_usu);
$cant_consul = mysqli_num_rows($exe_consul);

if($cant_consul > 0)
{
    echo "El usuario con ese ID ya está registrado en la base de datos";
    echo "<br><a href='usuarios.php'><input type='button' value='Regresar'></a>";
}
else if(!filter_var($email, FILTER_VALIDATE_EMAIL) && !empty($email))
{
    echo "El email no es válido";
    echo "<br><a href='usuarios.php'><input type='button' value='Regresar'></a>";
}
else
{
    //registrar usuario
    $insert = "INSERT INTO usuario (ID, nombres, apellidos, email, id_rol, estado, pass) VALUES ($id, '$nombres', '$apellidos', '$email', $id_rol, '$estado', '$pas')";
    $exe_insert = mysqli_query($conexion, $insert);
    if(!$exe_insert)
    {
        echo "Error al registrar el nuevo usuario: " . mysqli_error($conexion);
        echo "<br><a href='usuarios.php'><input type='button' value='Regresar'></a>";
    }
    else
    {
        header('Location: usuarios.php');
    }
}


?>
