# --- INÍCIO DA CONFIGURAÇÃO ---

# 1. Caminho da pasta RAIZ onde a busca por arquivos começará (incluindo todas as subpastas).
$caminhoOrigem = "C:\Origem"

# 2. Caminho da pasta para onde TODOS os arquivos serão copiados.
$caminhoDestino = "C:\Destino"

# --- FIM DA CONFIGURAÇÃO ---

#region --- CÓDIGO DA JANELA GRÁFICA (UI TOTALMENTE REDESENHADA) ---
function Get-UserInput {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    #region --- Paleta de Cores ---
    $colorHeader = [System.Drawing.ColorTranslator]::FromHtml("#2C3E50")  # Azul Ardósia Escuro
    $colorBackground = [System.Drawing.ColorTranslator]::FromHtml("#ECF0F1") # Cinza Muito Claro
    $colorFooter = [System.Drawing.ColorTranslator]::FromHtml("#FFFFFF")  # Branco
    $colorButtonOK = [System.Drawing.ColorTranslator]::FromHtml("#3498DB")  # Azul Claro
    $colorButtonOKHover = [System.Drawing.ColorTranslator]::FromHtml("#2980B9") # Azul Claro (Mais Escuro)
    $colorButtonCancel = [System.Drawing.ColorTranslator]::FromHtml("#BDC3C7")# Cinza Prata
    $colorButtonCancelHover = [System.Drawing.ColorTranslator]::FromHtml("#95A5A6") # Cinza Prata (Mais Escuro)
    $colorTextLight = [System.Drawing.ColorTranslator]::FromHtml("#FFFFFF")  # Branco
    $colorTextDark = [System.Drawing.ColorTranslator]::FromHtml("#34495E")   # Azul Ardósia
    $colorFocus = $colorButtonOK
    #endregion

    # Configurações do formulário principal
    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Cópia Rápida de Propostas'
    $form.Size = New-Object System.Drawing.Size(450, 400) # Ligeiramente maior
    $form.StartPosition = 'CenterScreen'
    $form.FormBorderStyle = 'FixedDialog'
    $form.MaximizeBox = $false
    $form.BackColor = $colorBackground
    $form.Font = New-Object System.Drawing.Font("Segoe UI", 9)

    # Painel do Cabeçalho
    $headerPanel = New-Object System.Windows.Forms.Panel
    $headerPanel.Size = New-Object System.Drawing.Size($form.Width, 60)
    $headerPanel.Dock = 'Top'
    $headerPanel.BackColor = $colorHeader
    $form.Controls.Add($headerPanel)

    $titleLabel = New-Object System.Windows.Forms.Label
    $titleLabel.Text = "Cópia de Documentos"
    $titleLabel.ForeColor = $colorTextLight
    $titleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
    $titleLabel.AutoSize = $true
    $titleLabel.Location = New-Object System.Drawing.Point(15, 15)
    $headerPanel.Controls.Add($titleLabel)
    
    # Painel do Rodapé
    $footerPanel = New-Object System.Windows.Forms.Panel
    $footerPanel.Size = New-Object System.Drawing.Size($form.Width, 55)
    $footerPanel.Dock = 'Bottom'
    $footerPanel.BackColor = $colorFooter
    $form.Controls.Add($footerPanel)
    
    # Rótulo de instrução
    $labelPropostas = New-Object System.Windows.Forms.Label
    $labelPropostas.Text = 'Cole as propostas abaixo (uma por linha):'
    $labelPropostas.Font = New-Object System.Drawing.Font("Segoe UI", 10)
    $labelPropostas.ForeColor = $colorTextDark
    $labelPropostas.AutoSize = $true
    $labelPropostas.Location = New-Object System.Drawing.Point(20, 80) # Abaixo do cabeçalho
    $form.Controls.Add($labelPropostas)
    
    # Caixa de Texto com borda de foco
    $textBoxPanel = New-Object System.Windows.Forms.Panel # Painel que servirá de borda
    $textBoxPanel.Location = New-Object System.Drawing.Point(23, 110)
    $textBoxPanel.Size = New-Object System.Drawing.Size(384, 184)
    $textBoxPanel.BackColor = [System.Drawing.Color]::Silver
    $textBoxPanel.Padding = New-Object System.Windows.Forms.Padding(2)
    $form.Controls.Add($textBoxPanel)

    $textBoxPropostas = New-Object System.Windows.Forms.TextBox
    $textBoxPropostas.Dock = 'Fill'
    $textBoxPropostas.Multiline = $true
    $textBoxPropostas.ScrollBars = 'Vertical'
    $textBoxPropostas.AcceptsReturn = $true
    $textBoxPropostas.MaxLength = 0
    $textBoxPropostas.BorderStyle = 'None'
    $textBoxPropostas.Font = New-Object System.Drawing.Font("Consolas", 10) # Fonte monoespaçada para números
    $textBoxPropostas.Add_Enter({ $textBoxPanel.BackColor = $colorFocus })
    $textBoxPropostas.Add_Leave({ $textBoxPanel.BackColor = [System.Drawing.Color]::Silver })
    $textBoxPanel.Controls.Add($textBoxPropostas)
    
    # Créditos
    $creditosLabel = New-Object System.Windows.Forms.Label
    $creditosLabel.Text = 'Projetado por Natan Sousa'
    $creditosLabel.ForeColor = [System.Drawing.Color]::Gray
    $creditosLabel.Font = New-Object System.Drawing.Font($form.Font, [System.Drawing.FontStyle]::Italic)
    $creditosLabel.AutoSize = $true
    $creditosLabel.Location = New-Object System.Drawing.Point(12, 18)
    $footerPanel.Controls.Add($creditosLabel)
    
    # Botões OK e Cancelar
    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(265, 12)
    $okButton.Size = New-Object System.Drawing.Size(80, 30)
    $okButton.Text = 'OK'
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $okButton.FlatStyle = 'Flat'
    $okButton.FlatAppearance.BorderSize = 0
    $okButton.BackColor = $colorButtonOK
    $okButton.ForeColor = $colorTextLight
    $okButton.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
    $okButton.Add_MouseEnter({ $this.BackColor = $colorButtonOKHover })
    $okButton.Add_MouseLeave({ $this.BackColor = $colorButtonOK })
    $form.AcceptButton = $okButton
    $footerPanel.Controls.Add($okButton)
    
    $cancelButton = New-Object System.Windows.Forms.Button
    $cancelButton.Location = New-Object System.Drawing.Point(350, 12)
    $cancelButton.Size = New-Object System.Drawing.Size(80, 30)
    $cancelButton.Text = 'Cancelar'
    $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $cancelButton.FlatStyle = 'Flat'
    $cancelButton.FlatAppearance.BorderSize = 0
    $cancelButton.BackColor = $colorButtonCancel
    $cancelButton.ForeColor = $colorTextDark
    $cancelButton.Add_MouseEnter({ $this.BackColor = $colorButtonCancelHover })
    $cancelButton.Add_MouseLeave({ $this.BackColor = $colorButtonCancel })
    $form.CancelButton = $cancelButton
    $footerPanel.Controls.Add($cancelButton)
    
    $form.Add_Shown({$textBoxPropostas.Select()})
    $result = $form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        return $textBoxPropostas.Lines
    } else {
        return $null
    }
}
#endregion

# --- LÓGICA PRINCIPAL DO SCRIPT ---

try {
    if (-not (Test-Path -Path $caminhoOrigem -PathType Container)) {
        throw "ERRO CRÍTICO: O caminho de origem '$caminhoOrigem' não foi encontrado. Verifique se o caminho está correto e acessível."
    }
    if (-not (Test-Path -Path $caminhoDestino -PathType Container)) {
        Write-Host "AVISO: A pasta de destino '$caminhoDestino' não existe. Criando agora..." -ForegroundColor Yellow
        New-Item -Path $caminhoDestino -ItemType Directory -Force | Out-Null
    }
    
    $propostasDesejadas = Get-UserInput

    if ($null -eq $propostasDesejadas) { Write-Host "Processo cancelado pelo usuário."; return }

    $propostasDesejadas = $propostasDesejadas | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | ForEach-Object { $_.Trim() }
    
    if ($propostasDesejadas.Count -eq 0) { Write-Host "Nenhuma proposta foi inserida. Encerrando o script."; return }
    
    Write-Host "----------------------------------------------------" -ForegroundColor Green
    Write-Host "Otimização: Lendo todos os arquivos do diretório de origem (e subpastas) uma única vez. Aguarde..." -ForegroundColor Yellow
    $todosOsArquivosDaOrigem = Get-ChildItem -Path $caminhoOrigem -Recurse -File
    Write-Host "Análise da origem concluída. $($todosOsArquivosDaOrigem.Count) arquivos encontrados." -ForegroundColor Green
    Write-Host "----------------------------------------------------"

    Write-Host "Iniciando verificação para $($propostasDesejadas.Count) propostas..." -ForegroundColor Green
    Write-Host "----------------------------------------------------"

    foreach ($propostaDesejada in $propostasDesejadas) {
        # --- NOVA LÓGICA DE BUSCA EM DUAS ETAPAS ---

        # ETAPA 1: Tenta encontrar o arquivo com o número EXATO que foi digitado.
        Write-Host "Buscando proposta '$propostaDesejada'..."
        $arquivosEncontrados = $todosOsArquivosDaOrigem | Where-Object { $_.Name.StartsWith($propostaDesejada) }

        # ETAPA 2: Se NADA foi encontrado E a proposta é curta, tenta a busca com "00" na frente.
        if (($null -eq $arquivosEncontrados) -and ($propostaDesejada.Length -lt 9)) {
            $termoBuscaPadded = "00" + $propostaDesejada
            Write-Host "   -> INFO: Não encontrado. Tentando como '$termoBuscaPadded'..." -ForegroundColor Magenta
            $arquivosEncontrados = $todosOsArquivosDaOrigem | Where-Object { $_.Name.StartsWith($termoBuscaPadded) }
        }

        # Verificação FINAL: Se depois das duas tentativas ainda não encontrou nada, informa o usuário e pula para a próxima.
        if ($null -eq $arquivosEncontrados) {
            Write-Host "   -> AVISO: Nenhum arquivo encontrado para esta proposta." -ForegroundColor Gray
            continue
        }
        
        Write-Host "   -> SUCESSO: $($arquivosEncontrados.Count) arquivo(s) encontrado(s) para '$propostaDesejada'." -ForegroundColor Cyan
        
        # Copia cada um dos arquivos que foram encontrados (seja na primeira ou segunda tentativa)
        foreach ($arquivo in $arquivosEncontrados) {
            $caminhoDestinoFinal = Join-Path -Path $caminhoDestino -ChildPath $arquivo.Name
            
            Copy-Item -Path $arquivo.FullName -Destination $caminhoDestinoFinal -Force

            Write-Host "      - Arquivo '$($arquivo.Name)' copiado."
        }
    }

    Write-Host "----------------------------------------------------" -ForegroundColor Green
    Write-Host "Processo concluído." -ForegroundColor Green
}
catch {
    Write-Host "----------------------------------------------------" -ForegroundColor Red
    Write-Host "OCORREU UM ERRO INESPERADO!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Detalhes do Erro: $($_.Exception.Message)" -ForegroundColor Yellow
    Write-Host "----------------------------------------------------"
}
finally {
    Write-Host ""
    Read-Host -Prompt "O script terminou. Pressione Enter para fechar esta janela"
}