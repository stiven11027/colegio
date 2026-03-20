<?php
include '../ASSETS/conexion.php';

$documento = intval($_GET['doc'] ?? 0);
if($documento == 0) die('ID no valido');

// Protección: No permitir eliminar si es el único administrador
if($documento == 1) {
    $check_admin = "SELECT COUNT(*) as total FROM usuario WHERE id_rol = 1 AND estado = 'Activo'";
    $result_admin = mysqli_query($conexion, $check_admin);
    $row_admin = mysqli_fetch_assoc($result_admin);
    
    if($row_admin['total'] <= 1) {
        echo "<script>alert('No se puede eliminar el único administrador del sistema'); window.location='usuarios.php';</script>";
        die;
    }
}

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