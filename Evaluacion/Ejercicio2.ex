# -----------------------------------------
# Programación Declarativa Aplicada
# Ejercicio de evaluación continua 2
# -----------------------------------------
#
# IMPORTANTE: No olvides indicar tu nombre y apellidos en la siguiente línea
#
# Nombre y Apellidos: Karina Vianey Prado Oropeza

defmodule Ejercicio2 do

  # Ejercicio 1
  # -----------

  defp partir_cadena(str) do
    case String.split(str, ":") do
      [a, b, c] -> {:ok, a, b, c}
      _ -> :error
    end
  end

  defp convertir_a_numero(str, min, max) do
    case Integer.parse(str) do
      {num, ""} -> if min <= num and num <= max, do: {:ok, num}, else: :error
      _ -> :error
    end
  end

  def validar_hora(str) do
    with {:ok, a, b, c} <- partir_cadena(str),
         {:ok, h} <- convertir_a_numero(a, 0, 23),
         {:ok, m} <- convertir_a_numero(b, 0, 59),
         {:ok, s} <- convertir_a_numero(c, 0, 59) do

        {:ok, h,m,s}
    end
  end

  # Ejercicio 2
  # -----------

  defmodule Evento do
    defstruct [:nombre, :dia, :hora_inicio, :hora_fin]
  end

  def lista_eventos() do
    [
      # Lunes: incluye solapamientos y eventos contiguos (no solapantes)
      %Evento{nombre: "Inauguración", dia: :lunes, hora_inicio: 9, hora_fin: 10},
      %Evento{nombre: "Taller de Elixir", dia: :lunes, hora_inicio: 10, hora_fin: 12},
      %Evento{nombre: "Charla de IA", dia: :lunes, hora_inicio: 11, hora_fin: 13},
      %Evento{nombre: "Mesa Redonda", dia: :lunes, hora_inicio: 11, hora_fin: 12},
      %Evento{nombre: "Clausura Lunes", dia: :lunes, hora_inicio: 16, hora_fin: 18},

      # Martes: un evento que contiene a otro y uno puntual (hora_inicio == hora_fin)
      %Evento{nombre: "Hackathon", dia: :martes, hora_inicio: 9, hora_fin: 14},
      %Evento{nombre: "Café Networking", dia: :martes, hora_inicio: 11, hora_fin: 11},
      %Evento{nombre: "Taller de Seguridad", dia: :martes, hora_inicio: 15, hora_fin: 17},

      # Miércoles: sin solapamientos
      %Evento{nombre: "Conferencia Cloud", dia: :miercoles, hora_inicio: 10, hora_fin: 12},
      %Evento{nombre: "Taller de Rust", dia: :miercoles, hora_inicio: 12, hora_fin: 14}
    ]
  end

  def eventos_disponibles(eventos, dia, hora_limite) do
  	for evento <- eventos, evento.dia == dia and evento.hora_fin <= hora_limite do
      evento.nombre
    end
  end

  def solapan?(%Evento{} = e1, %Evento{} = e2) do
  	e1.dia == e2.dia and
    (e1.hora_inicio < e2.hora_fin and
     e2.hora_inicio < e1.hora_fin)
  end

  def eventos_solapados(eventos, dia) do
  	for e1 <- eventos, e2 <- eventos,
        e1.nombre != e2.nombre and
        e1.dia == e2.dia and
        solapan?(e1, e2),
        uniq: true do
        {e1.nombre, e2.nombre}
    end
  end


  # Ejercicio 3
  # -----------

  def potencias(v) do
   Stream.iterate(1,&(&1*v))
  end

  def evaluar_polinomio(p, v) do
   Stream.zip_with(p, potencias(v), fn x, y -> x*y end)
   |> Enum.reduce(fn x, acc -> x + acc end)
  end

  def derivada(ps) do
   grado = length(ps) - 1
   Enum.zip_with(tl(ps), 1..grado, fn x, y -> x*y end)
  end

  def raiz(p, v_ini, n) do
    p_prima = derivada(p)
    Stream.iterate(v_ini, &(&1 - evaluar_polinomio(p,&1)/evaluar_polinomio(p_prima,&1)))
    |> Enum.at(n)
  end

end
