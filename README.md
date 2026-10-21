<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:2C3E50,100:3498DB&height=200&section=header&text=Extrair%20Arquivos%20por%20Proposta&fontSize=38&fontColor=ffffff&animation=fadeIn&desc=Cópia%20rápida%20de%20documentos%20com%20PowerShell&descSize=18&descAlignY=72" alt="Banner" />

![Plataforma](https://img.shields.io/badge/plataforma-Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=for-the-badge&logo=powershell&logoColor=white)
![Interface](https://img.shields.io/badge/interface-Windows%20Forms-3498DB?style=for-the-badge)
![Versão](https://img.shields.io/badge/versão-1.0-22c55e?style=for-the-badge)

</div>

---

## 📄 Sobre o projeto

Script em **PowerShell** com interface gráfica que localiza e **copia automaticamente todos os arquivos de uma lista de propostas** a partir de uma pasta de origem (incluindo subpastas) para uma pasta de destino.

Em vez de procurar proposta por proposta manualmente, basta colar os números em uma janela e o script faz o resto.

## ✨ Funcionalidades

- 🖥️ Janela gráfica para colar as propostas, uma por linha
- 🔍 Busca recursiva em todas as subpastas da origem
- ⚡ Leitura única do diretório de origem, o que deixa a busca rápida mesmo com muitos arquivos
- 🧠 Busca inteligente em duas etapas: primeiro o número exato e, se não achar, tenta com `00` na frente (propostas com menos de 9 dígitos)
- 📁 Cria a pasta de destino automaticamente, se ela não existir
- 📋 Copia todos os arquivos que começam com o número da proposta
- 🎨 Log colorido no terminal (sucesso, aviso e erro)

## 🖼️ Screenshots

<div align="center">
  <img width="457" height="416" alt="print2" src="https://github.com/user-attachments/assets/210c1d45-9853-4a6a-8cc3-4c54ca93063d" />
</div>

## ⚙️ Configuração

Abra o arquivo `extrair-arquivos-por-proposta.ps1` e edite as duas variáveis no início:

```powershell
# Pasta raiz onde a busca será feita (inclui subpastas)
$caminhoOrigem = "C:\Origem"

# Pasta para onde os arquivos serão copiados
$caminhoDestino = "C:\Destino"
```

## 🚀 Como usar

1. Baixe o arquivo `extrair-arquivos-por-proposta.ps1`.
2. Configure os caminhos de origem e destino (veja acima).
3. Clique com o botão direito no arquivo e escolha **Executar com o PowerShell**.
4. Cole os números das propostas (um por linha) e clique em **OK**.
5. Acompanhe o resultado no terminal. Os arquivos aparecem na pasta de destino.

> ⚠️ Se o Windows bloquear a execução, abra o PowerShell e rode:
> `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`

## 👤 Créditos

- Criado por **Natan Sousa**

[![GitHub](https://img.shields.io/badge/GitHub-natan7z-181717?style=for-the-badge&logo=github)](https://github.com/natan7z)

---

<div align="center">
  ⭐ Se o projeto foi útil, deixe uma estrela!
</div>
