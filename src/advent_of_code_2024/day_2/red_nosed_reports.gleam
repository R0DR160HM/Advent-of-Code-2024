import gleam/int
import gleam/list
import gleam/order
import gleam/string
import simplifile

const filepath = "./src/advent_of_code_2024/day_2/input.txt"

pub fn run() {
  let assert Ok(input) = simplifile.read(from: filepath)
  string.split(input, "\r\n")
  |> parse_reports
  |> total_safe_reports
}

// Part two
fn is_safe_with_error_dampener(report) {
  case is_safe(report) {
    True -> True
    False -> {
      let validated_reports =
        list.index_map(report, fn(_, index) {
          let #(head, tail) = list.split(report, index)
          let assert [_ignore, ..tail] = tail
          list.flatten([head, tail])
          |> is_safe
        })
      list.contains(validated_reports, True)
    }
  }
}

fn parse_reports(reports) {
  list.map(reports, fn(report) {
    string.split(report, " ")
    |> list.map(fn(val) {
      let assert Ok(val) = int.parse(val)
      val
    })
  })
}

fn total_safe_reports(reports) {
  safe_reports_loop(reports, 0)
}

fn safe_reports_loop(reports, total) {
  case reports {
    [current, ..rest] -> {
      case is_safe_with_error_dampener(current) {
        True -> {
          safe_reports_loop(rest, total + 1)
        }
        False -> safe_reports_loop(rest, total)
      }
    }
    [] -> total
  }
}

fn is_safe(report) {
  is_safe_loop(report, order.Eq)
}

// Part one
fn is_safe_loop(report, direction) {
  case report {
    [current, next, ..rest] -> {
      let diff = current - next
      case diff, direction {
        d, _ if d == 0 || d > 3 || d < -3 -> False
        d, order.Gt if d > 0 -> is_safe_loop([next, ..rest], direction)
        d, order.Lt if d < 0 -> is_safe_loop([next, ..rest], direction)
        d, order.Eq if d > 0 -> is_safe_loop([next, ..rest], order.Gt)
        d, order.Eq if d < 0 -> is_safe_loop([next, ..rest], order.Lt)
        _, _ -> False
      }
    }
    _ -> True
  }
}
