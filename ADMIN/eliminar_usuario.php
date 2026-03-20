<?php
include '../ASSETS/conexion.php';

$documento = intval($_GET['doc'] ?? 0);
if($documento == 0) die('ID no valido');

//eliminar el usuario
$del_usu = "DELETE FROM usuario WHERE ID = $documento";
$exe_del = mysqli_query($conexion, $del_usu);
if(!$exe_del)
{
    echo "Error al eliminar el usuario: " . mysqli_error($conexion);
    echo "<br><a href='usuarios.php'>Regresar</a>";
}
else
{
    header('Location: usuarios.php');
}
?>