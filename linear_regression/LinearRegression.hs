-- LinearRegression.hs
-- Linear regression functions.
-- © 2011 Daniel Hjort

import HUnit

-- Functions

slopeGivenSeries :: [(Double, Double)] -> Double
slopeGivenSeries s = (fromIntegral(length s) * sumOfProducts s - sumOfFirst s * sumOfSecond s) /
                     (fromIntegral(length s) * sumOfFirstSquared s - square' (sumOfFirst s))

interceptGivenSeries :: [(Double, Double)] -> Double
interceptGivenSeries s = (1 / fromIntegral(length s)) * sumOfSecond s -
                         (slopeGivenSeries s / fromIntegral(length s)) * sumOfFirst s

sumOfProducts :: [(Double, Double)] -> Double
sumOfProducts s = sum [ pairProduct sn  | sn <- s ]

sumOfFirst :: [(Double, Double)] -> Double
sumOfFirst s = sum [ fst(sn)  | sn <- s ]

sumOfSecond :: [(Double, Double)] -> Double
sumOfSecond s = sum [ snd(sn)  | sn <- s ]

sumOfFirstSquared :: [(Double, Double)] -> Double
sumOfFirstSquared s = sum [ square'(fst(sn))  | sn <- s ]

pairProduct :: (Double, Double) -> Double
pairProduct (x, y) = x * y

square' :: Double -> Double
square' n = n * n

-- Test cases

testSlopeGivenSeries = TestCase(assertEqual "" 1 (slopeGivenSeries [(0, 0), (1, 1), (2, 2)]))

testInterceptGivenSeries = TestCase(assertEqual "" 0 (interceptGivenSeries [(0, 0), (1, 1), (2, 2)]))

testSumOfProducts = TestCase(assertEqual "" 15 (sumOfProducts [(1, 1), (1, 1), (2, 2), (3, 3)]))

testSumOfFirst = TestCase(assertEqual "" 6 (sumOfFirst [(1, 0), (2, 2), (3, 3)]))

testSumOfSecond = TestCase(assertEqual "" 6 (sumOfSecond [(0, 1), (2, 2), (3, 3)]))

testSumOfFirstSquared = TestCase(assertEqual "" 14 (sumOfFirstSquared [(1, 0), (2, 2), (3, 3)]))

testPairProduct = TestCase(assertEqual "" 36 (pairProduct (6, 6)))

testSquare = TestCase(assertEqual "" 4.0 (square' 2.0))

allTests = TestList [TestLabel "testSlopeGivenSeries" testSlopeGivenSeries,
                     TestLabel "testInterceptGivenSeries" testInterceptGivenSeries,
                     TestLabel "testSumOfProducts" testSumOfProducts,
                     TestLabel "testSumOfFirst" testSumOfFirst,
                     TestLabel "testSumOfSecond" testSumOfSecond,
                     TestLabel "testSumOfFirstSquared" testSumOfFirstSquared,
                     TestLabel "testPairProduct" testPairProduct,
                     TestLabel "testSquare" testSquare] 
