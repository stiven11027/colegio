<?php
include '../ASSETS/conexion.php';

if(!isset($_GET['doc'])) {
    die('ID no especificado');
}

$id = intval($_GET['doc']);
?>

<html>
    <head>
        <title>Actualizar Usuario - Sistema Académico</title>
        <link href="../CSS/css/sb-admin-2.css" rel="stylesheet" />
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card shadow">
                        <div class="card-header bg-primary text-white">
                            <h4>Actualizar Usuario</h4>
                        </div>
                        <div class="card-body">
                            <?php
                            $consul_info = "SELECT * FROM usuario WHERE ID = '$id'";
                            $exe_consul = mysqli_query($conexion, $consul_info);
                            $data_consul = mysqli_fetch_assoc($exe_consul);
                            
                            if(!$data_consul) {
                                echo "<div class='alert alert-danger'>Usuario no encontrado</div>";
                                echo "<a href='usuarios.php' class='btn btn-secondary'>Volver</a>";
                                die;
                            }
                            ?>
                            <h5 class="mb-4">Usuario: <?= $data_consul['nombres'] . ' ' . $data_consul['apellidos']?></h5>
                            
                            <form action="actu_usu.php" method="POST">
                                <div class="form-group">
                                    <label>ID (No editable)</label>
                                    <input type="number" class="form-control" value="<?= $data_consul['ID']?>" readonly>
                                </div>
                                
                                <div class="form-group">
                                    <label>Nombres *</label>
                                    <input type="text" name="up_nombres" class="form-control" value="<?= $data_consul['nombres']?>" required>
                                </div>
                                
                                <div class="form-group">
                                    <label>Apellidos *</label>
                                    <input type="text" name="up_apellidos" class="form-control" value="<?= $data_consul['apellidos']?>" required>
                                </div>
                                
                                <div class="form-group">
                                    <label>Email</label>
                                    <input type="email" name="up_email" class="form-control" value="<?= $data_consul['email']?>">
                                </div>
                                
                                <div class="form-group">
                                    <label>Rol *</label>
                                    <select name="up_rol" class="form-control" required>
                                        <option value="1" <?= ($data_consul['id_rol'] == 1) ? 'selected' : '' ?>>Administrador</option>
                                        <option value="2" <?= ($data_consul['id_rol'] == 2) ? 'selected' : '' ?>>Profesor</option>
                                        <option value="3" <?= ($data_consul['id_rol'] == 3) ? 'selected' : '' ?>>Estudiante</option>
                                        <option value="4" <?= ($data_consul['id_rol'] == 4) ? 'selected' : '' ?>>Acudiente</option>
                                    </select>
                                </div>
                                
                                <div class="form-group">
                                    <label>Estado *</label>
                                    <select name="up_estado" class="form-control" required>
                                        <option value="Activo" <?= ($data_consul['estado'] === 'Activo') ? 'selected' : '' ?>>Activo</option>
                                        <option value="Inactivo" <?= ($data_consul['estado'] === 'Inactivo') ? 'selected' : '' ?>>Inactivo</option>
                                    </select>
                                </div>
                                
                                <div class="form-group">
                                    <label>Contraseña</label>
                                    <input type="password" name="up_pass" class="form-control" placeholder="Dejar vacío para mantener la actual">
                                </div>
                                
                                <input type="hidden" name="documento" value="<?= $data_consul['ID']?>">
                                
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary btn-block">Actualizar</button>
                                    <a href="usuarios.php" class="btn btn-secondary btn-block mt-2">Cancelar</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="../CSS/vendor/jquery/jquery.min.js"></script>
        <script src="../CSS/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
