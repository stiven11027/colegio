<?php
date_default_timezone_set('America/Bogota');
session_start();
?>
<html>
    <head>
        <title>Sistema de Gestión Académica - Colegio Rural</title>
        <!-- PLUGINS CSS STYLE -->
        <link href="CSS/css/sb-admin-2.css" rel="stylesheet" />
        <style>
            body {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
            }
            .login-card {
                box-shadow: 0 14px 28px rgba(0,0,0,0.15), 0 10px 10px rgba(0,0,0,0.12);
                border-radius: 10px;
            }
            .login-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 20px;
                border-radius: 10px 10px 0 0;
                text-align: center;
            }
            .login-header h2 {
                margin: 0;
                font-weight: bold;
            }
            .login-header p {
                margin: 5px 0 0 0;
                font-size: 14px;
            }
            .alert-top {
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <main class="container">
            <div class="row justify-content-center">
                <div class="col-md-5 col-lg-4">
                    <!-- Mensaje de alerta -->
                    <?php if(isset($_SESSION['msg'])){?>
                    <div class="alert alert-dismissible alert-danger alert-top" role="alert">
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        <strong>Error:</strong> <?= $_SESSION['msg']?>
                    </div>
                    <?php unset($_SESSION['msg']); }?>

                    <div class="card login-card mt-5">
                        <div class="login-header">
                            <h2>SGA</h2>
                            <p>Sistema de Gestión Académica</p>
                        </div>
                        <div class="card-body p-4">
                            <form action="validar.php" method="POST">
                                <div class="form-group mb-3">
                                    <label for="doc" class="form-label">Documento/ID</label>
                                    <input type="number" class="form-control form-control-lg" id="doc" name="doc" placeholder="Ingrese su documento" required autofocus>
                                </div>
                                
                                <div class="form-group mb-4">
                                    <label for="pass" class="form-label">Contraseña</label>
                                    <input type="password" class="form-control form-control-lg" id="pass" name="pass" placeholder="Ingrese su contraseña" required>
                                </div>

                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary btn-lg">Ingresar</button>
                                </div>
                            </form>
                        </div>
                        <div class="card-footer text-center bg-light">
                            <small class="text-muted">Colegio Rural © 2024</small>
                        </div>
                    </div>

                    <!-- Test Users Info -->
                    <div class="alert alert-info mt-4" role="alert">
                        <small><strong>Usuarios de prueba:</strong></small>
                        <ul class="mb-0 mt-2">
                            <li><small>Admin: ID=1, Pass=admin123</small></li>
                            <li><small>Profesor: ID=2, Pass=prof123</small></li>
                            <li><small>Estudiante: ID=1072493621, Pass=1111</small></li>
                        </ul>
                    </div>
                </div>
            </div>
        </main>

        <script src="CSS/vendor/jquery/jquery.min.js"></script>
        <script src="CSS/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
