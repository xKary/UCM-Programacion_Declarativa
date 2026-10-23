
OPERADO PIPE |

String.graphemes(String.upcase(String.trim("      hola        ")))
["H", "O", "L", "A"]
"      hola        " |> String.trim() |> String.upcase() |> String.graphemes()
["H", "O", "L", "A"]
"      hola        " |> String.trim() |> String.upcase() |> String.ends_with?("a")
false
[1,2,3,4,5,6] |> Enum.filter(&(&1 >= 3)) |> Enum.map(&(&1 * 2))
[6, 8, 10, 12]

KEYWORDS
kw = [{:enero, 31}, {:febrero, 28}, {:abril, 30}]
[enero: 31, febrero: 28, abril: 30]

MAP
- No permite claves duplicadas

map = %{"david"=>31, "luia"=>21}
%{"david" => 31, "luia" => 21}
map
%{"david" => 31, "luia" => 21}
case Map.fetch(map, "luia") do
    {:ok, v} -> "encontre a Luisa con edad #{v}"
    :error -> "no se encontro a luisa"
    end

-- Ajuste de patrones
map =%{"Diana" => 21, "Miguel" => 23}
%{"Diana" => x} = map
