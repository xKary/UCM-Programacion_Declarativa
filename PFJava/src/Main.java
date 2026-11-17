import java.util.function.Function;

<T, S> List<S> map(List<T> xs, Function<T, S> f) {
    List<S> result = new ArrayList<>();

    for (T x : xs) {
        result.add(f.apply(x));
    }

    return result;
}

void main() {
    var xs = Arrays.asList(6, 3, 1, 5, 10);

    Function<Integer, Integer> f = x -> x * 2;

    var ys = map(xs, f);
    System.out.println(ys);

    System.out.println(map(xs, x -> x * x));
    System.out.println(map(xs, String::valueOf));
    System.out.println(map(xs, x -> x % 2 == 0));
}
