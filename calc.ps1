Function DisplayMenu {
    Write-Host "Selecione uma operação:"
    Write-Host "1 - Adicionar"
    Write-Host "2 - Subtrair"
    Write-Host "3 - Multiplicar"
    Write-Host "4 - Dividir"
    Write-Host "5 - Sair"
}

Function Add-Numbers {
    Param(
        [Double]$num1,
        [Double]$num2
    )
    $result = $num1 + $num2
    Write-Host "O resultado é: $result"
}

Function Subtract-Numbers {
    Param(
        [Double]$num1,
        [Double]$num2
    )
    $result = $num1 - $num2
    Write-Host "O resultado é: $result"
}

Function Multiply-Numbers {
    Param(
        [Double]$num1,
        [Double]$num2
    )
    $result = $num1 * $num2
    Write-Host "O resultado é: $result"
}

Function Divide-Numbers {
    Param(
        [Double]$num1,
        [Double]$num2
    )
    if ($num2 -eq 0) {
        Write-Host "Não é possível dividir por zero."
    }
    else {
        $result = $num1 / $num2
        Write-Host "O resultado é: $result"
    }
}

do {
    DisplayMenu
    $choice = Read-Host "Digite o número da operação que deseja realizar"
    switch ($choice) {
        1 {
            $num1 = Read-Host "Digite o primeiro número"
            $num2 = Read-Host "Digite o segundo número"
            Add-Numbers $num1 $num2
        }
        2 {
            $num1 = Read-Host "Digite o primeiro número"
            $num2 = Read-Host "Digite o segundo número"
            Subtract-Numbers $num1 $num2
        }
        3 {
            $num1 = Read-Host "Digite o primeiro número"
            $num2 = Read-Host "Digite o segundo número"
            Multiply-Numbers $num1 $num2
        }
        4 {
            $num1 = Read-Host "Digite o primeiro número"
            $num2 = Read-Host "Digite o segundo número"
            Divide-Numbers $num1 $num2
        }
        5 {
            Write-Host "Saindo da calculadora."
            break
        }
        default {
            Write-Host "Opção inválida. Tente novamente."
        }
    }
} while ($true)