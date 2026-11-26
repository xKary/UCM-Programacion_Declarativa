# Ejercicio 21
defmodule Nodo do
    defstruct [iz: :vacio,val: :nil,der: :vacio]
end

defmodule Arbol do
  def arbol_ejemplo() do
    %Nodo{
      val: 3,
      iz: %Nodo{val: 2},
      der: %Nodo{val: 1}
    }
  end

 def suma(:vacio), do: 0
 def suma(%Nodo{iz: iz, val: val, der: der}) do
  suma(iz) + val + suma(der)
 end

 def height(:vacio), do: 0
 def height(%Nodo{iz: iz, val: val, der: der}) do
  1 + max(height(iz), height(der))
 end

 def balanced?(:vacio), do: true
 def balanced?(%Nodo{iz: iz, val: val, der: der}) do
  abs(height(iz) - height(der)) <= 1 and balanced?(iz) and balanced?(der)
 end

  def mapArbol(:vacio, _), do: :vacio
  def mapArbol(%Nodo{iz: iz, val: val, der: der}, f) do
    %Nodo{
      iz: mapArbol(iz,f),
      val: f.(val),
      der: mapArbol(der,f)}
  end

  def reduce(:vacio, ac, _), do: ac
  def reduce(%Nodo{iz: iz, val: val, der: der}, ac, f) do
    acc_iz = reduce(iz, ac, f)
    acc_der = reduce(der, ac, f)
    f.(val, acc_iz, acc_der)
  end

  def suma(t) do
    reduce(t, 0, fn x, n_iz, n_der -> x + n_iz + n_der end)
  end

  def altura(t) do
    reduce(t, 0, fn _, h_iz, h_der ->
      1 + max(h_iz, h_der)
    end)
  end

  # Ejericico 22
  def map_option([],_), do: {:ok, []}
  def map_option([x | xs], f) do
    with {:ok, y} <- f.(x),
         {:ok, ys} <- map_option(xs,f) do
           {:ok,[y | ys]}
         end
  end

  # Ejericico 23
  def reduce_option([],ac,_), do: {:ok,ac}
  def reduce_option([x | xs], ac, f) do
    with {:ok, n_ac} <- f.(x, ac) do
      reduce_option(xs, n_ac, f)
    end
  end
end

# Ejercicio 25
defmodule ModuleJSON do
  defmodule JSONNumber do
    defstruct [:value]
  end

  defmodule JSONString do
    defstruct [:value]
  end

  defmodule JSONBoolean do
    defstruct [:value]
  end

  defmodule JSONNull do
    defstruct []
  end

  defmodule JSONArray do
    defstruct elements: []
  end

  defmodule JSONObject do
    defstruct fields: []
  end

  defimpl String.Chars, for: JSONNumber do
    def to_string(%JSONNumber{value: v}), do: Kernel.to_string(v)
  end

   defimpl String.Chars, for: JSONBoolean do
    def to_string(%JSONBoolean{value: v}), do: Kernel.to_string(v)
  end

  defimpl String.Chars, for: JSONNull do
    def to_string(%JSONNull{}), do: "null"
  end

  defimpl String.Chars, for: JSONString do
    def to_string(%JSONString{value: v}) do
      escapado =
        v
        |> String.replace("\\", "\\\\")
        |> String.replace("\"", "\\\"")
        |> String.replace("\n", "\\n")
        |> String.replace("\t", "\\t")
        |> String.replace("\r", "\\r")

      "\"#{escapado}\""
    end
  end

   defimpl String.Chars, for: JSONArray do
    def to_string(%JSONArray{elements: elems}) do
      contenido =
        elems
        |> Enum.map(&Kernel.to_string/1)
        |> Enum.join(", ")

      "[#{contenido}]"
    end
  end

    defimpl String.Chars, for: JSONObject do
    def to_string(%JSONObject{fields: fields}) do
      pares =
        fields
        |> Enum.map(fn {clave, valor} ->
          clave_json = Kernel.to_string(%JSONString{value: clave})
          valor_json = Kernel.to_string(valor)
          "#{clave_json}: #{valor_json}"
        end)
        |> Enum.join(", ")

      "{#{pares}}"
    end
  end

end

defmodule LeerJSON do
  def leer_tercera_persona() do
    case File.read("info.json") do
      {:ok, str} ->
        case JSON.decode(str) do
          {:ok, lista} ->
            case lista do
              [_, _, tercero | _] -> tercero
              _ -> IO.puts("El JSON no tiene una lista válida")
            end
          {:error, _} -> IO.puts("No es un JSON válido")
        end
      {:error, _} -> IO.puts("Fallo en la lectura")
    end
  end

   def leer_tercera_persona_with() do
    with {:ok, str} <- File.read("info.json"),
         {:ok, lista} <- JSON.decode(str),
         [_, _, tercero | _] <- lista do
           tercero
    else
      {:error, :enoent} -> {:error, :file_not_found}
    end
  end
end

defmodule Robot do
  # Hoja 1 Ejercicio 24
  @map_size 10

  def move({x,y}, :norte) when y < @map_size, do: {:ok, {x,y + 1}}
  def move({x,y}, :sur) when y > 1, do: {:ok, {x,y - 1}}
  def move({x,y}, :este) when x < @map_size, do: {:ok, {x + 1 ,y}}
  def move({x,y}, :oeste) when x > 1, do: {:ok, {x - 1 ,y}}
  def move(_,_), do: :error

  def move_list(pos, []), do: {:ok,pos}
  def move_list(pos, [dir | dirs]) do
    with {:ok, pos1} <- move(pos, dir) do
         move_list(pos1, dirs)
        end
  end

  # Hoja 1 Ejercicio 26
  def media_edades_fumadores(nombre_fichero, valor_defecto) do
    lista_edades = File.stream!(nombre_fichero)
    |> CSV.decode!()
    |> Stream.drop(1)
    |> Stream.filter(fn [_,_,fumador,_] -> fumador == "SI" end)
    |> Enum.map(fn [_,edad,_,_] -> String.to_integer(edad) end)
    |> Enum.take(10)

    if Enum.empty?(lista_edades) do
      valor_defecto.()
    else
      Enum.sum(lista_edades) / Enum.count(lista_edades)
    end
  end

  # Hoja 1 Ejercicio 27
  def exp(x,n) do
    pots = Stream.iterate(1, &(&1 * x))
    facts = Stream.iterate({1,0},
                           fn {f, n} -> {f * (n + 1), n + 1} end)
                           |> Stream.map(fn {f,_} -> f end)
    Stream.zip_with(pots,facts, &(&1/&2))
    |> Stream.take(n)
    |> Enum.sum()
  end

  # Ejercicio 28
  def ternas(n) do
    for a <- 1..n, b <- a..n, c <- 1..n, a * a + b * b == c * c do
      {a, b, c}
    end
  end

  # Ejercicio 29
  def comb(i, j) when j == 1 or j == i, do: 1
  def comb(i, j) when j > 1 and j < i do
    comb(i - 1, j - 1) + comb(i - 1, j)
  end

end
