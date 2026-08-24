<!DOCTYPE html>
<html lang="pt-br">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Login - Lumière</title>

    <link rel="stylesheet" href="public/assets/css/login.css">

</head>


<body>

    <main class="login-container">


        <!-- =====================================
             LADO ESQUERDO - IMAGEM
        ====================================== -->

        <section class="login-image">

            <img
                src="public/assets/css/img/lumiere-login.png"
                alt="Lumière Velas Aromáticas"
            >

        </section>



        <!-- =====================================
             LADO DIREITO - LOGIN
        ====================================== -->

        <section class="login-form">


            <div class="form-content">


                <!-- TÍTULO -->

                <div class="welcome">

                    <span>Bem-vinda à</span>

                    <h1>
                        Lumière
                        <b>✦</b>
                    </h1>

                    <p>
                        Sua loja de velas aromáticas
                        <span></span>
                    </p>

                </div>



                <!-- FORMULÁRIO -->

                <form
                    method="post"
                    action="/loja_roupas/index.php?controller=auth&action=login"
                >


                    <!-- E-MAIL -->

                    <div class="input-group">

                        <label for="email">
                            E-mail
                        </label>

                        <div class="input-box">

                            <span class="input-icon">
                                
                            </span>

                            <input
                                type="email"
                                id="email"
                                name="email"
                                placeholder="Digite seu e-mail"
                                required
                                autocomplete="username"
                            >

                        </div>

                    </div>



                    <!-- SENHA -->

                    <div class="input-group">

                        <label for="senha">
                            Senha
                        </label>

                        <div class="input-box">

                            <span class="input-icon">
                                
                            </span>

                            <input
                                type="password"
                                id="senha"
                                name="senha"
                                placeholder="Digite sua senha"
                                required
                                autocomplete="current-password"
                            >

                        </div>


                        <!-- ESQUECEU SENHA -->

                        <div class="forgot">

                            <a href="#">
                                Esqueceu sua senha?
                            </a>

                        </div>

                    </div>



                    <!-- BOTÃO ENTRAR -->

                    <button
                        type="submit"
                        class="btn-login"
                    >

                        Entrar

                    </button>



                    <!-- BOTÃO CADASTRAR -->

                    <a
                        href="index.php?controller=usuario&action=create"
                        class="btn-register"
                    >

                        Cadastrar

                    </a>


                </form>

            </div>

        </section>


    </main>

</body>

</html>