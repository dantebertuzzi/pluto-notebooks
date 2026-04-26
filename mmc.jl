### A Pluto.jl notebook ###
# v0.20.21

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 80907e41-0bb7-48ec-875f-7b2d1d6c52be
begin
	using Markdown
	using InteractiveUtils
	using PlutoUI
end

# ╔═╡ 207d8dbb-7a16-4dc0-b634-543f74c4a909
# 0000
md"""
# 🧮 MMC (Mínimo Múltiplo Comum)

Digite os números separados por vírgula:
"""

# 0001

# ╔═╡ 00d6bfc1-13f8-400f-823d-e6d20c4eb12c
md"""
## Qual é o `menor` número que é múltiplo de todos esses números ao mesmo tempo?
"""

# ╔═╡ b669d67c-b06d-4502-a3cf-dd78a4122684
@bind numeros_input TextField(default="48, 84", placeholder="Ex: 12, 18, 24")

# ╔═╡ 0dbc2b9e-95d3-4392-bc7a-0bd445b93fb3
function calcular_mmc_com_html(entrada::String)
    try
        numeros = [parse(Int, strip(s)) for s in split(entrada, ",")]

        if any(n <= 0 for n in numeros)
            return HTML.div("⚠️ Digite apenas números inteiros positivos.", style="color: #ff6b6b; font-weight: bold;")
        end

        nums = copy(numeros)
        divisor = 2
        linhas = String[]
        fatores = Int[]

        while any(n > 1 for n in nums)
            if any(n % divisor == 0 for n in nums)
                linha_numeros = join(["<td>" * string(n) * "</td>" for n in nums], "")
                push!(linhas, "<tr>$linha_numeros<td><b>$divisor</b></td></tr>")
                
                for i in eachindex(nums)
                    if nums[i] % divisor == 0
                        nums[i] ÷= divisor
                    end
                end
                push!(fatores, divisor)
            else
                divisor += divisor == 2 ? 1 : 2
            end
        end

        linha_final = join(["<td>" * string(n) * "</td>" for n in nums], "")
        push!(linhas, "<tr>$linha_final<td></td></tr>")

        fatores_str = join(string.(fatores), " × ")
        mmc_valor = prod(fatores)

        html_table = """
        <style>
            table.mmc {
                border-collapse: collapse;
                margin-top: 20px;
                font-family: 'Segoe UI', sans-serif;
                font-size: 16px;
                color: #e2e8f0;
                border-radius: 8px;
                overflow: hidden;
                background: #1e1e1e;
                box-shadow: 0 2px 12px rgba(0, 0, 0, 0.3);
            }

            .mmc td {
                padding: 10px 16px;
                border-bottom: 1px solid #2d2d2d;
                text-align: center;
            }

            .mmc tr:last-child td {
                border-bottom: none;
            }

            .mmc td:last-child {
                background-color: #2c2c2c;
                font-weight: 600;
                color: #63b3ed;
                border-left: 1px solid #3a3a3a;
            }

            .resultado {
                margin-top: 20px;
                font-size: 18px;
                font-weight: bold;
                color: #90cdf4;
                font-family: 'Segoe UI', sans-serif;
                padding: 10px 16px;
                background: #2a2a2a;
                border: 1px solid #444;
                border-radius: 6px;
                text-align: center;
            }
        </style>

        <table class="mmc">
            $(join(linhas, "\n"))
        </table>

        <div class="resultado">
            $fatores_str = $mmc_valor
        </div>
        """

        return HTML(html_table)

    catch
        return HTML.div("⚠️ Erro: Digite apenas números válidos separados por vírgula.", style="color: #ff6b6b; font-weight: bold;")
    end
end



# ╔═╡ 157e6117-d62c-4493-b04f-d123c28087c8
resultado_html = calcular_mmc_com_html(numeros_input);

# ╔═╡ 06f512d7-6c99-4aee-aa57-e23c13116964
md"""
---
"""

# ╔═╡ a481d2b7-7d2a-453a-9002-e01a5d5c5018
resultado_html

# 0006

# ╔═╡ 9d25de36-ff6b-4e9b-a94c-27e12d71a858
md"""
---

### ℹ️ Como funciona:

- Dividimos todos os números pelos mesmos divisores primos
- Começamos com 2, depois 3, 5, 7, 11, etc.
- Continuamos até todos os números se tornarem 1
- O MMC é o produto de todos os divisores utilizados

---

*💡 Feito com Pluto.jl + HTML/CSS*
"""

# ╔═╡ 6ecde4e1-e2aa-44a4-ac84-b01c7c9c2e19
md"""
### 📊 Questão de Estatística (Bacharelado)

Três sensores de qualidade ambiental enviam sinais a cada **15**, **20** e **24** minutos. Todos iniciaram às **8h00**.

**Pergunta:**  
> Em qual próximo horário os três sensores irão enviar sinais simultaneamente?

---

### 🧮 Resolução:

Queremos o MMC de 15, 20 e 24:

```
15 = 3 × 5  
20 = 2² × 5  
24 = 2³ × 3
```

MMC é o produto dos fatores com maior expoente:

```
MMC(15, 20, 24) = 2³ × 3 × 5 = 8 × 3 × 5 = 120 minutos
```

---

### 🕒 Resposta final:

**8h00 + 120 minutos = 10h00**

Os sensores se sincronizam novamente às **10h00** ✅

"""

# ╔═╡ 01ebba6f-5310-4fda-b333-04e7d3d6cade
md"""
!!! hint "Pergunta (MMC)"

    Em uma fábrica, uma máquina A realiza manutenção a cada **12 dias**, e uma máquina B a cada **18 dias**.

    👉 **Se hoje as duas passaram por manutenção no mesmo dia, em quantos dias isso acontecerá novamente ao mesmo tempo?**
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
InteractiveUtils = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
Markdown = "d6f4376e-aef5-505a-96c1-9c027394607a"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.68"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.1"
manifest_format = "2.0"
project_hash = "aa722571aab7382c27fbe429569c786bcd9a03e7"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.3.0+1"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.11.1+1"

[[deps.LibGit2]]
deps = ["LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.9.0+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "OpenSSL_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.3+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.12.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2025.5.20"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.29+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.1+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7d2f8f21da5db6a806faf7b9b292296da42b2810"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.12.0"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "ec9e63bd098c50e4ad28e7cb95ca7a4860603298"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.68"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.Tricks]]
git-tree-sha1 = "6cae795a5a9313bbb4f60683f7263318fc7d1505"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.10"

[[deps.URIs]]
git-tree-sha1 = "bef26fb046d031353ef97a82e3fdb6afe7f21b1a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.6.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.3.1+2"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.15.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.64.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.5.0+2"
"""

# ╔═╡ Cell order:
# ╠═80907e41-0bb7-48ec-875f-7b2d1d6c52be
# ╟─207d8dbb-7a16-4dc0-b634-543f74c4a909
# ╟─00d6bfc1-13f8-400f-823d-e6d20c4eb12c
# ╟─b669d67c-b06d-4502-a3cf-dd78a4122684
# ╟─0dbc2b9e-95d3-4392-bc7a-0bd445b93fb3
# ╟─157e6117-d62c-4493-b04f-d123c28087c8
# ╟─06f512d7-6c99-4aee-aa57-e23c13116964
# ╟─a481d2b7-7d2a-453a-9002-e01a5d5c5018
# ╟─9d25de36-ff6b-4e9b-a94c-27e12d71a858
# ╟─6ecde4e1-e2aa-44a4-ac84-b01c7c9c2e19
# ╟─01ebba6f-5310-4fda-b333-04e7d3d6cade
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
