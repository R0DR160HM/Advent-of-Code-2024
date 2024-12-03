import advent_of_code_2024/day_3/mull_it_over
import gleam/io
import simplifile

pub fn main() {
  let assert Ok(input) = simplifile.read(from: "input.txt")
  mull_it_over.match(input)
  |> io.debug
}
