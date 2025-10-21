//
//  Programmers.swift
//  01_Complexity
//
//  Created by Bran on 10/20/25.
//

import Foundation

/*
 영어 점수와 수학 점수의 평균 점수를 기준으로 학생들의 등수를 매기려고 합니다.
 영어 점수와 수학 점수를 담은 2차원 정수 배열 score가 주어질 때, 영어 점수와 수학 점수의 평균을 기준으로 매긴 등수를 담은 배열을 return하도록 solution 함수를 완성해주세요.

 [제한사항]
 - 0 ≤ score[0], score[1] ≤ 100
 - 1 ≤ score의 길이 ≤ 10
 - score의 원소 길이는 2입니다.
 - score는 중복된 원소를 갖지 않습니다.

 score  result
 입력: [[80, 70], [90, 50], [40, 70], [50, 80]] / 출력: [1, 2, 4, 3]
 입력: [[80, 70], [70, 80], [30, 50], [90, 100], [100, 90], [100, 100], [10, 30]] / 출력 [4, 4, 6, 2, 2, 1, 7]
 */
func 등수매기기(_ score: [[Int]]) -> [Int] {
  []
}


/*
 정수 l과 r이 주어졌을 때, l 이상 r이하의 정수 중에서 숫자 "0"과 "5"로만 이루어진 모든 정수를 오름차순으로 저장한 배열을 return 하는 solution 함수를 완성해 주세요.
 만약 그러한 정수가 없다면, -1이 담긴 배열을 return 합니다.

 [제한사항]
 1 ≤ l ≤ r ≤ 1,000,000


 l  r  result
 5  555  [5, 50, 55, 500, 505, 550, 555]
 10  20  [-1]
 */
func 배열만들기2(_ l: Int, _ r: Int) -> [Int] {
  []
}


/*
 문자열 s가 매개변수로 주어집니다. s에서 한 번만 등장하는 문자를 사전 순으로 정렬한 문자열을 return 하도록 solution 함수를 완성해보세요. 한 번만 등장하는 문자가 없을 경우 빈 문자열을 return 합니다.

 [제한사항]
 0 < s의 길이 < 1,000
 s는 소문자로만 이루어져 있습니다.

 s  result
 "abcabcadc"  "d"
 "abdc"  "abcd"
 "hello"  "eho"
 */
func 한번만등장한문자(_ s: String) -> String {
  ""
}


/*
 0번부터 n - 1번까지 n명의 학생 중 3명을 선발하는 전국 대회 선발 고사를 보았습니다. 등수가 높은 3명을 선발해야 하지만, 개인 사정으로 전국 대회에 참여하지 못하는 학생들이 있어 참여가 가능한 학생 중 등수가 높은 3명을 선발하기로 했습니다.

 각 학생들의 선발 고사 등수를 담은 정수 배열 rank와 전국 대회 참여 가능 여부가 담긴 boolean 배열 attendance가 매개변수로 주어집니다. 전국 대회에 선발된 학생 번호들을 등수가 높은 순서대로 각각 a, b, c번이라고 할 때 10000 × a + 100 × b + c를 return 하는 solution 함수를 작성해 주세요.

 [제한사항]
 3 ≤ rank의 길이 = attendance의 길이 ≤ 100
 rank[i]는 i번 학생의 선발 고사 등수를 의미합니다.
 rank의 원소는 1부터 n까지의 정수로 모두 서로 다릅니다.
 attendance[i]는 i번 학생의 전국 대회 참석 가능 여부를 나타냅니다.
 attendance[i]가 true라면 참석 가능, false면 참석 불가능을 의미합니다.
 attendance의 원소 중 적어도 3개는 true입니다.

 rank  attendance  result
 [3, 7, 2, 5, 4, 6, 1]  [false, true, true, true, true, false, false]  20403
 [1, 2, 3]  [true, true, true]  102
 [6, 1, 5, 2, 3, 4]  [true, false, true, false, false, true]  50200
 */
func 전국대회선발고사(_ rank:[Int], _ attendance:[Bool]) -> Int {
  0
}
