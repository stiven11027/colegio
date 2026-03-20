<?php
date_default_timezone_set('America/Bogota');
session_start();
include '../ASSETS/conexion.php';

if(!isset($_SESSION['documento']) || $_SESSION['documento'] === '' || $_SESSION['documento'] === null) {
    $_SESSION['msg'] = "Debe iniciar sesion";
    header('Location: ../index.php');
    die;
}

$doc_usu = intval($_SESSION['documento']);
$consul_usu = "SELECT * FROM usuario WHERE ID = $doc_usu";
$exe_usu = mysqli_query($conexion, $consul_usu);

if(!$exe_usu || mysqli_num_rows($exe_usu) == 0) {
    $_SESSION['msg'] = "Usuario no encontrado";
    session_destroy();
    header('Location: ../index.php');
    die;
}

$data_usu = mysqli_fetch_assoc($exe_usu);
?>

<html>
    <head>
        <title>Sistema CRUD</title>
        <!-- PLUGINS CSS STYLE -->
        <link href="../css/style.css" rel="stylesheet" />
    </head>