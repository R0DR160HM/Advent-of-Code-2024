import advent_of_code_2024/day_3/mull_it_over
import gleeunit/should

pub fn match_test() {
  "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
  |> mull_it_over.match
  |> should.equal(48)
}
