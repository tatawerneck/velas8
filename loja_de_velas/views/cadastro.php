<!DOCTYPE html>
<html lang="pt-BR">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="public/assets/css/cadastro.css">

    <title>Cadastrar Vendedor - Lumière</title>

</head>


<body>


    <main class="cadastro-container">


        <!-- =====================================
             LOGO LUMIÈRE
        ====================================== -->

        <header class="logo">

            <div class="logo-icon">
                ♨
            </div>

            <h1>Lumière</h1>

            <p>VELAS AROMÁTICAS</p>

        </header>



        <!-- =====================================
             CARD DE CADASTRO
        ====================================== -->

        <section class="cadastro-card">


            <!-- DETALHE SUPERIOR -->

            <div class="ornamento">

                <span>────</span>

                <b>❀</b>

                <span>────</span>

            </div>



            <!-- TÍTULO -->

            <h2>
                Cadastro de Vendedor
            </h2>


            <div class="linha-decorativa">
                ─── ✦ ───
            </div>



            <!-- =====================================
                 FORMULÁRIO
            ====================================== -->

            <form
                action="index.php?controller=usuario&action=store"
                method="POST"
            >


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



                <!-- E-MAIL -->

                <div class="campo">

                    <label for="email">
                        E-mail
                    </label>

                    <div class="input-container">

                        <span class="icone">
                            
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



                <!-- BOTÃO -->

                <button
                    type="submit"
                    class="btn-cadastrar"
                >

                    Cadastrar

                </button>


            </form>



            <!-- DETALHE INFERIOR -->

            <div class="ornamento inferior">

                <span>────</span>

                <b>❀</b>

                <span>────</span>

            </div>


        </section>


    </main>


</body>

</html>