import gleam/int
import gleam/list
import gleam/regexp
import gleam/string

pub fn match(input: String) {
  let assert Ok(re) =
    regexp.from_string("mul\\(\\d+,\\d+\\)|do\\(\\)|don't\\(\\)")
  regexp.scan(re, input)
  |> multiply_matches(0, True)
}

fn multiply_matches(matches: List(regexp.Match), total, enabled) {
  case matches {
    [current, ..rest] -> {
      case current.content, enabled {
        "don't()", _ -> multiply_matches(rest, total, False)
        "do()", _ -> multiply_matches(rest, total, True)
        _, False -> multiply_matches(rest, total, enabled)
        value, True -> {
          let assert [Ok(lvalue), Ok(rvalue)] =
            string.replace(value, "mul(", "")
            |> string.replace(")", "")
            |> string.split(",")
            |> list.map(int.parse)
          { lvalue * rvalue } + total
          |> multiply_matches(rest, _, enabled)
        }
      }
    }
    [] -> total
  }
}
