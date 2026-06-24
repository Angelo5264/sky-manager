<div id="chat-bubble" onclick="toggleChat()">
    💬
</div>

<div id="chat-box">
    <div class="chat-header">
        SkyManager IA
        <button onclick="toggleChat()">×</button>
    </div>

    <div id="chat-messages"></div>

    <div class="chat-input">
        <input type="text" id="chatText" placeholder="Escribe tu consulta...">
        <button onclick="sendMessage()">Enviar</button>
    </div>
</div>

<style>
    #chat-bubble {
        position: fixed;
        right: 25px;
        bottom: 25px;
        width: 60px;
        height: 60px;
        background: linear-gradient(135deg, #1e3c72, #2a5298);
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 28px;
        cursor: pointer;
        box-shadow: 0 8px 25px rgba(0,0,0,.25);
        z-index: 9999;
    }

    #chat-box {
        position: fixed;
        right: 25px;
        bottom: 95px;
        width: 340px;
        height: 430px;
        background: white;
        border-radius: 18px;
        box-shadow: 0 8px 30px rgba(0,0,0,.25);
        display: none;
        flex-direction: column;
        overflow: hidden;
        z-index: 9999;
    }

    .chat-header {
        background: linear-gradient(135deg, #1e3c72, #2a5298);
        color: white;
        padding: 14px;
        font-weight: bold;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .chat-header button {
        background: none;
        border: none;
        color: white;
        font-size: 22px;
    }

    #chat-messages {
        flex: 1;
        padding: 12px;
        overflow-y: auto;
        background: #f4f8fb;
    }

    .msg-user, .msg-bot {
        padding: 9px 12px;
        border-radius: 14px;
        margin-bottom: 10px;
        max-width: 85%;
        font-size: 14px;
    }

    .msg-user {
        background: #2a5298;
        color: white;
        margin-left: auto;
    }

    .msg-bot {
        background: white;
        color: #333;
        border: 1px solid #ddd;
        margin-right: auto;
    }

    .chat-input {
        display: flex;
        border-top: 1px solid #ddd;
    }

    .chat-input input {
        flex: 1;
        border: none;
        padding: 12px;
        outline: none;
    }

    .chat-input button {
        border: none;
        background: #1e3c72;
        color: white;
        padding: 0 15px;
    }
</style>

<script>
    function toggleChat() {
        const box = document.getElementById("chat-box");
        box.style.display = box.style.display === "flex" ? "none" : "flex";
    }

    async function sendMessage() {
        const input = document.getElementById("chatText");
        const messages = document.getElementById("chat-messages");
        const mensaje = input.value.trim();

        if (mensaje === "") return;

        messages.innerHTML += `<div class="msg-user">${mensaje}</div>`;
        input.value = "";

        try {
            const response = await fetch("http://127.0.0.1:5000/send/Json", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    role: "user",
                    content: mensaje
                })
            });

            const data = await response.json();

            messages.innerHTML += `<div class="msg-bot">${data.content}</div>`;
            messages.scrollTop = messages.scrollHeight;

        } catch (error) {
            messages.innerHTML += `<div class="msg-bot text-danger">Error al conectar con la IA.</div>`;
            console.error(error);
        }
    }
</script>