#!/bin/bash

# Declarando Alias para posts -- checagem de reputaçoes -- like em posts -- deslike em posts

postricardo() { ./freechains --host=localhost:8334 chain '#terror' post --sign=939068E40CDA4DD255F5BE4651C679D61306E4E652BC9C8F13AC770E6735C73A04E7F4EF7C0761882955FDFFD3F78698F2A4DB0460FDBC3211A7178E4B37ADD9 inline "$*"; }

postisa() {  ./freechains --host=localhost:8333 chain '#terror' post --sign=022A52BBC9DF103BD4CC634310934948E9446CB8B33538DA24678A0250540B3886E0A1851DD26F0A5FD518E871F18A5FCB4025ABC0A837EFB684334FCDCE312F inline "$*"; }

postbruno() {  ./freechains --host=localhost:8331 chain '#terror' post --sign=9F1271B49800A817EB384E92628CFACB6D8035C98FED418BE8B1FA5AAB6B96E1D3CC2CFE6158EB4798047B79A74504C87643E491D091C90D6802E91FC0456F19 inline "$*"; }

postthiago() {  ./freechains --host=localhost:8332 chain '#terror' post --sign=18EBB5A4935B360A088FA2C350F66E99D508BA64B03D2093C53F4C862969D9B142FA1265196E7AD51523DBFACF0D7FE250DEE6C3AF7EC9D40280730E73C43770 inline "$*"; }

repsbruno() { ./freechains --host=localhost:8331 chain '#terror' reps D3CC2CFE6158EB4798047B79A74504C87643E491D091C90D6802E91FC0456F19 ;}

repsisa() { ./freechains --host=localhost:8333 chain '#terror' reps 86E0A1851DD26F0A5FD518E871F18A5FCB4025ABC0A837EFB684334FCDCE312F ;}

repsthiago() { ./freechains --host=localhost:8332 chain '#terror' reps 42FA1265196E7AD51523DBFACF0D7FE250DEE6C3AF7EC9D40280730E73C43770  ;}

repsricardo() { ./freechains --host=localhost:8334 chain '#terror' reps 04E7F4EF7C0761882955FDFFD3F78698F2A4DB0460FDBC3211A7178E4B37ADD9 ;} 

likethiago() { ./freechains --host=localhost:8332 chain '#terror' like "$1" --sign=18EBB5A4935B360A088FA2C350F66E99D508BA64B03D2093C53F4C862969D9B142FA1265196E7AD51523DBFACF0D7FE250DEE6C3AF7EC9D40280730E73C43770 ; }

likeisa() {  ./freechains --host=localhost:8333 chain '#terror' like "$1" --sign=022A52BBC9DF103BD4CC634310934948E9446CB8B33538DA24678A0250540B3886E0A1851DD26F0A5FD518E871F18A5FCB4025ABC0A837EFB684334FCDCE312F ; }

likebruno() {  ./freechains --host=localhost:8331 chain '#terror' like "$1" --sign=9F1271B49800A817EB384E92628CFACB6D8035C98FED418BE8B1FA5AAB6B96E1D3CC2CFE6158EB4798047B79A74504C87643E491D091C90D6802E91FC0456F19 ; }

dislikethiago() { ./freechains --host=localhost:8332 chain '#terror' dislike "$1" --sign=18EBB5A4935B360A088FA2C350F66E99D508BA64B03D2093C53F4C862969D9B142FA1265196E7AD51523DBFACF0D7FE250DEE6C3AF7EC9D40280730E73C43770 ; }

dislikeisa() {  ./freechains --host=localhost:8333 chain '#terror' dislike "$1" --sign=022A52BBC9DF103BD4CC634310934948E9446CB8B33538DA24678A0250540B3886E0A1851DD26F0A5FD518E871F18A5FCB4025ABC0A837EFB684334FCDCE312F ; }

dislikebruno() {  ./freechains --host=localhost:8331 chain '#terror' dislike "$1" --sign=9F1271B49800A817EB384E92628CFACB6D8035C98FED418BE8B1FA5AAB6B96E1D3CC2CFE6158EB4798047B79A74504C87643E491D091C90D6802E91FC0456F19 ; }


# Setando timestamp inicial em 1º de março de 2025
TIMESTAMP=1740787200000

# Funçao para checar o progresso da simulaçao
progresso() {
    local DIF=$((TIMESTAMP - 1740787200000))
    DIAS=$((DIF / 86400000))
    echo "Dias passados desde o início da simulaçao: $DIAS" 
    echo "Reputação do Bruno: $(repsbruno)"
    
    echo "Reputação do Thiago: $(repsthiago)"
    
    echo "Reputação do Ricardo: $(repsricardo)"
    
    echo "Reputação da Isabela: $(repsisa)" ;}

# Funçao para sincronizar a cadeia entre os nós

sinc(){
    ./freechains --host=localhost:$1 peer localhost:8331 send '#terror'
    ./freechains --host=localhost:$1 peer localhost:8332 send '#terror'
    ./freechains --host=localhost:$1 peer localhost:8333 send '#terror'
    ./freechains --host=localhost:$1 peer localhost:8334 send '#terror' ;}

# Iniciando os nós

./freechains-host --port=8331 start /tmp/no1 --no-tui > /dev/null 2>&1 &
./freechains-host --port=8332 start /tmp/no2 --no-tui > /dev/null 2>&1 &
./freechains-host --port=8333 start /tmp/no3 --no-tui > /dev/null 2>&1 &
./freechains-host --port=8334 start /tmp/no4 --no-tui > /dev/null 2>&1 &

sleep 5

# Setando timestamp em 1º de março de 2025
for PORT in $(seq 8331 8334); do
    echo "Iniciando o timestamp na porta $PORT"
    ./freechains-host now $TIMESTAMP --port=$PORT
done

# Gerando as chaves públicas e privadas para cada usuário
./freechains --host=localhost:8331 keys pubpvt "bruno"

./freechains --host=localhost:8332 keys pubpvt "thiago o novato"

./freechains --host=localhost:8333 keys pubpvt "isabela a leitora"

./freechains --host=localhost:8334 keys pubpvt "ricardo o troll"

# Acessando a chain por cada nó e usuário -- Bruno, o pioneiro pelo nó 1  -- Thiago, o newbie pelo nó 2 -- Isabela, a leitora pelo nó 3 -- Ricardo, o troll pelo nó 4

./freechains --host=localhost:8331 chains join '#terror' D3CC2CFE6158EB4798047B79A74504C87643E491D091C90D6802E91FC0456F19 
./freechains --host=localhost:8332 chains join '#terror' D3CC2CFE6158EB4798047B79A74504C87643E491D091C90D6802E91FC0456F19 
./freechains --host=localhost:8333 chains join '#terror' D3CC2CFE6158EB4798047B79A74504C87643E491D091C90D6802E91FC0456F19 
./freechains --host=localhost:8334 chains join '#terror' D3CC2CFE6158EB4798047B79A74504C87643E491D091C90D6802E91FC0456F19 

# Iniciando posts --  Bruno posta sempre pela porta 8331 -- Thiago pela porta 8332 -- Isabela pela porta 8333 -- Ricardo pela porta 8334

postbruno "Uma vez eu estava escutando meu irmao me chamar no andar de baixo da minha casa, quando lembrei que meu irmao estava na escola.."
sinc 8331

POST=$(postthiago "Sou novo aqui.. essa é minha primeira história. Ouvi passos atras de mim na floresta, e quando olhei pra tras..")
sinc 8332

likebruno "$POST"
sinc 8331
postbruno "Historia ta meio incompleta.. mas voce aprende com o tempo"
sinc 8331

# Avançando 7 dias
TIMESTAMP=$((TIMESTAMP + 604800000))
for PORT in $(seq 8331 8334); do
    echo "Avançando os dias na porta $PORT"
    ./freechains-host now $TIMESTAMP --port=$PORT
done

progresso

POST=$(postricardo "HAHAHAH FORUM IDIOTA, SÓ HISTORIA FALSA.")
sinc 8334
dislikebruno "$POST"
sinc 8331
dislikethiago "$POST"
sinc 8332
POST=$(postthiago "Se ta tao incomodado assim sai do fórum")
sinc 8332
likebruno "$POST"
sinc 8331

TIMESTAMP=$((TIMESTAMP + 604800000))
for PORT in $(seq 8331 8334); do
    echo "Avançando os dias na porta $PORT"
    ./freechains-host now $TIMESTAMP --port=$PORT
done

progresso

POST=$(postthiago "Dormi na casa do meu primo e ouvi alguém sussurrando meu nome. Ele disse que a vó dele também ouve.")
sinc 8332
likebruno "$POST"
sinc 8331
likeisa "$POST"
sinc 8333
POST=$(postisa "Ótima história")
sinc 8333
likethiago "$POST"
sinc 8332
POST=$(postricardo "Isso foi horrível, voces sentem medo de qualquer coisa")
sinc 8334
dislikethiago "$POST"
sinc 8332
dislikebruno "$POST"
sinc 8331
dislikeisa "$POST"
sinc 8333

TIMESTAMP=$((TIMESTAMP + 90000000))
for PORT in $(seq 8331 8334); do
    echo "Avançando os dias na porta $PORT"
    ./freechains-host now $TIMESTAMP --port=$PORT
done

progresso

POST=$(postisa "Não sou muito de postar histórias, gosto mais de ler.. mas aqui vai: Quando eu era criança, acordei de madrugada e vi alguém parado no corredor. Pensei que era minha mãe, mas ela estava dormindo no quarto.")
sinc 8333
likebruno "$POST"
sinc 8331
likethiago "$POST"
sinc 8332

# Avançando 7 dias
TIMESTAMP=$((TIMESTAMP + 604800000))
for PORT in $(seq 8331 8334); do
    echo "Avançando os dias na porta $PORT"
    ./freechains-host now $TIMESTAMP --port=$PORT
done

progresso

POST=$(postbruno "Pra dar uma movimentada por aqui.. Era uma vez, Jorge, uma criança curiosa. Um dia, Jorge levantou de noite e ouviu passos que não conseguia ver. Jorge nunca mais levantou durante a noite.")
sinc 8331
likethiago "$POST"
sinc 8332
postthiago "Que creepypasta incrível e macabra."
sinc 8332


# Avançando 15 dias

TIMESTAMP=$((TIMESTAMP + 1296000000))
for PORT in $(seq 8331 8334); do
    echo "Avançando os dias na porta $PORT"
    ./freechains-host now $TIMESTAMP --port=$PORT
done

progresso

postbruno "Já tiveram paralisia do sono? Se sim, compartilhe os detalhes."
sinc 8331
POST=$(postthiago "Teve uma vez que eu acordei e senti como se alguém estivesse sentado no meu peito. Eu não conseguia me mexer e nem falar.")
sinc 8332
likebruno "$POST"
sinc 8331

# Avançando 7 dias
TIMESTAMP=$((TIMESTAMP + 604800000))
for PORT in $(seq 8331 8334); do
    echo "Avançando os dias na porta $PORT"
    ./freechains-host now $TIMESTAMP --port=$PORT
done

progresso

POST=$(postthiago "Toda madrugada, quando dava 03:00, a TV de uma casa ligava sozinha, no mesmo canal.")
sinc 8332
likebruno "$POST"
sinc 8331
POST=$(postricardo "KKKK isso que dá usar uma TV velha, que creepypasta idiota.")
sinc 8334
dislikebruno "$POST"
sinc 8331
dislikethiago "$POST"
sinc 8332
postthiago "Cara, voce não se cansa.."
sinc 8332

# Avançando 10 dias
TIMESTAMP=$((TIMESTAMP + 864000000))
for PORT in $(seq 8331 8334); do
    echo "Avançando os dias na porta $PORT"
    ./freechains-host now $TIMESTAMP --port=$PORT
done

progresso

POST=$(postthiago "No velório, alguém bateu de dentro do caixão. Todos ouviram. Quando abriram, não havia mais corpo.")
sinc 8332
likeisa "$POST"
sinc 8333
POST=$(postisa "Gosto muito de ler essas histórias no trem, indo para minha faculdade. Obrigada por animarem minha viagem!")
sinc 8333
likebruno "$POST"
sinc 8331
likethiago "$POST"
sinc 8332
postthiago "Bom saber que consegui pegar o jeito das histórias."
sinc 8332

# Avançando 15 dias

TIMESTAMP=$((TIMESTAMP + 1296000000))
for PORT in $(seq 8331 8334); do
    echo "Avançando os dias na porta $PORT"
    ./freechains-host now $TIMESTAMP --port=$PORT
done

progresso

POST=$(postricardo "Era uma vez um fantasma parado em frente a uma casa... até descobrirem que era só uma roupa no varal.")
sinc 8334
dislikebruno "$POST"
sinc 8331

# Avançando 10 dias
TIMESTAMP=$((TIMESTAMP + 864000000))
for PORT in $(seq 8331 8334); do
    echo "Avançando os dias na porta $PORT"
    ./freechains-host now $TIMESTAMP --port=$PORT
done

progresso

dislikethiago "$POST"
sinc 8332
POST=$(postthiago "Marina gostava de fazer passeios a noite com seu cachorro. Um dia, quando voltou pra casa, um estranho tentou seguir ela até em casa. Não devemos temer só os fantasmas..")
sinc 8332
likeisa "$POST"
sinc 8333
likebruno "$POST"
sinc 8331

# Avançando 7 dias
TIMESTAMP=$((TIMESTAMP + 604800000))
for PORT in $(seq 8331 8334); do
    echo "Avançando os dias na porta $PORT"
    ./freechains-host now $TIMESTAMP --port=$PORT
done

progresso

POST=$(postthiago "Um menino foi tentar brincar de loira do banheiro.. e começou a ouvir barulhos vindo de uma das cabines. Ele saiu correndo na mesma hora.")
sinc 8332
likebruno "$POST"
sinc 8331

# Avançando 4 dias
TIMESTAMP=$((TIMESTAMP + 345600000))
for PORT in $(seq 8331 8334); do
    echo "Avançando os dias na porta $PORT"
    ./freechains-host now $TIMESTAMP --port=$PORT
done

progresso
