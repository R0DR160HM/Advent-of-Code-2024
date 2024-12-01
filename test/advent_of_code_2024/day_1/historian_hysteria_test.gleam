import advent_of_code_2024/day_1/historian_hysteria
import gleeunit/should

pub fn part_one_test() {
  historian_hysteria.part_one()
  |> should.equal(1_506_483)
}

pub fn part_two_test() {
  historian_hysteria.part_two()
  |> should.equal(23_126_924)
}
