#!/usr/bin/env bats

@test "pngquant binary is found in PATH" {
  run which pngquant
  [ "$status" -eq 0 ]
}