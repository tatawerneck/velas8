<!DOCTYPE html>
<html lang="pt-BR">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Lumière - Cadastro</title>

    <link rel="stylesheet" href="public/assets/css/cadastro.css">

</head>

<body>

    <div class="cadastro-container">


        <!-- =================================================
             MENU LATERAL
        ================================================== -->

        <aside class="sidebar">

            <div class="logo">

                <div class="logo-icon">
                    🕯️
                </div>

                <h1>Lumière</h1>

                <p>VELAS AROMÁTICAS</p>

                <div class="logo-decoration">
                    ─── ❀ ───
                </div>

            </div>


            <!-- MENU -->

            <nav class="menu">

                <a href="#" class="menu-item">
                    <span>⌂</span>
                    Início
                </a>

                <a href="#" class="menu-item">
                    <span></span>
                    Produtos
                </a>

                <a href="#" class="menu-item">
                    <span></span>
                    Categorias
                </a>

                <a href="#" class="menu-item">
                    <span>🛒</span>
                    Vendas
                </a>

                <a href="#" class="menu-item">
                    <span></span>
                    Clientes
                </a>

                <a href="#" class="menu-item active">
                    <span></span>
                    Cadastro
                </a>

                <a href="#" class="menu-item">
                    <span></span>
                    Configurações
                </a>

            </nav>


            <!-- FRASE -->

            <div class="sidebar-bottom">

                <div class="linha"></div>

                <div class="vela">
                    🕯️
                </div>

                <p>
                    Com cada vela,<br>
                    um momento especial.
                </p>

                <span>♥</span>

            </div>

        </aside>



        <!-- =================================================
             ÁREA PRINCIPAL
        ================================================== -->

        <main class="conteudo">


            <!-- CABEÇALHO -->

            <header class="cabecalho">

                <div>

                    <h2>
                        Criar conta
                    </h2>

                    <p>
                        Cadastre-se no sistema
                    </p>

                </div>

            </header>



            <!-- ÁREA DO CADASTRO -->

            <section class="cadastro-area">


                <!-- FORMULÁRIO -->

                <div class="cadastro-card">

                    <div class="ornamento">
                        ✦　❀　✦
                    </div>


                    <h3>
                        Bem-vindo(a)!
                    </h3>

                    <p class="descricao">
                        Preencha seus dados para criar sua conta.
                    </p>


                    <!-- =================================================
                         FORMULÁRIO
                         
                         IMPORTANTE:
                         Se seu PHP já possui um action funcionando,
                         mantenha o action antigo aqui.
                    ================================================== -->

                    <form method="POST"
                          action="index.php?controller=usuario&action=store">


                        <!-- NOME -->

                        <div class="campo">

                            <label for="nome">
                                Nome
                            </label>

                            <div class="input-container">

                                <span class="icone">
                                    
                                </span>

                                <input
                                    type="text"
                                    id="nome"
                                    name="nome"
                                    placeholder="Digite seu nome"
                                    required
                                >

                            </div>

                        </div>



                        <!-- EMAIL -->

                        <div class="campo">

                            <label for="email">
                                E-mail
                            </label>

                            <div class="input-container">

                                <span class="icone">
                                    ✉
                                </span>

                                <input
                                    type="email"
                                    id="email"
                                    name="email"
                                    placeholder="Digite seu e-mail"
                                    required
                                >

                            </div>

                        </div>



                        <!-- SENHA -->

                        <div class="campo">

                            <label for="senha">
                                Senha
                            </label>

                            <div class="input-container">

                                <span class="icone">
                                    
                                </span>

                                <input
                                    type="password"
                                    id="senha"
                                    name="senha"
                                    placeholder="Digite sua senha"
                                    required
                                >

                            </div>

                        </div>



                        <!-- CONFIRMAR SENHA -->

                        <div class="campo">

                            <label for="confirmar_senha">
                                Confirmar senha
                            </label>

                            <div class="input-container">

                                <span class="icone">
                                    
                                </span>

                                <input
                                    type="password"
                                    id="confirmar_senha"
                                    name="confirmar_senha"
                                    placeholder="Confirme sua senha"
                                    required
                                >

                            </div>

                        </div>



                        <!-- BOTÃO -->

                        <button
                            type="submit"
                            class="btn-cadastrar">

                            Criar minha conta

                        </button>


                    </form>


                    <!-- RODAPÉ DO CARD -->

                    <div class="rodape-card">

                        <span>
                            ✦
                        </span>

                        <p>
                            Sua experiência começa aqui.
                        </p>

                        <span>
                            ✦
                        </span>

                    </div>

                </div>



                <!-- =================================================
                     ÁREA DECORATIVA
                     
                     NÃO É OBRIGATÓRIO COLOCAR IMAGEM.
                     Se quiser uma imagem depois, coloque dentro
                     da div .imagem-produto.
                ================================================== -->

                <div class="decoracao">

                    <div class="brilho brilho-1">
                        ✦
                    </div>

                    <div class="brilho brilho-2">
                        ✦
                    </div>

                    <div class="brilho brilho-3">
                        ✦
                    </div>


                    <div class="imagem-produto">

                        <!--
                        Se quiser colocar uma imagem:

                        <img src="img/produto.png"
                             alt="Produto Lumière">

                        -->

                        <div class="vela-grande">

                            

                        </div>

                    </div>


                    <h4>
                        Lumière
                    </h4>

                    <p>
                        Mais cor,<br>
                        mais brilho,<br>
                        <span>mais você.</span>
                    </p>


                    <div class="decoracao-linha">
                        ─── ❀ ───
                    </div>

                </div>


            </section>


        </main>

    </div>

</body>

</html>