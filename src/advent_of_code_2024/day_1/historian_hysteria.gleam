import gleam/int
import gleam/list
import gleam/string
import simplifile

const filepath = "./src/advent_of_code_2024/day_1/input.txt"

pub fn part_one() {
  let assert Ok(input) = simplifile.read(from: filepath)
  let #(left_list, right_list) = split_lists(input)
  let left_list = list.sort(left_list, int.compare)
  let right_list = list.sort(right_list, int.compare)
  calculate_distance(left_list, right_list)
}

pub fn part_two() {
  let assert Ok(input) = simplifile.read(from: filepath)
  let #(left_list, right_list) = split_lists(input)
  calculate_total_similarity_score(left_list, right_list)
}

fn calculate_total_similarity_score(llist, rlist) {
  calculate_similarity_loop(llist, rlist, 0)
}

fn calculate_similarity_loop(llist, rlist, total) {
  case llist {
    [left, ..rest] -> {
      let times_in_the_right = list.count(rlist, fn(right) { right == left })
      let similarity_score = left * times_in_the_right
      calculate_similarity_loop(rest, rlist, total + similarity_score)
    }
    [] -> total
  }
}

fn calculate_distance(llist, rlist) {
  calculate_distance_loop(llist, rlist, 0)
}

fn calculate_distance_loop(llist, rlist, distance) {
  case llist, rlist {
    [left, ..lrest], [right, ..rrest] -> {
      let new_distance = case left - right {
        value if value >= 0 -> distance + value
        _ -> distance + { right - left }
      }
      calculate_distance_loop(lrest, rrest, new_distance)
    }
    _, _ -> distance
  }
}

fn split_lists(input: String) {
  string.split(input, "\r\n")
  |> split_lists_loop([], [])
}

fn split_lists_loop(
  value_pairs: List(String),
  llist: List(Int),
  rlist: List(Int),
) {
  case value_pairs {
    [current, ..rest] -> {
      let assert [left, right] = string.split(current, "   ")
      let assert Ok(left) = int.parse(left)
      let assert Ok(right) = int.parse(right)
      split_lists_loop(rest, [left, ..llist], [right, ..rlist])
    }
    [] -> #(llist, rlist)
  }
}
