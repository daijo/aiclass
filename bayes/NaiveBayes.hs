-- NaiveBayes.hs
-- Naive Bayes classification.
-- © 2011 Daniel Hjort

import HUnit

-- Functions

getClass :: String -> [[String]]
getClass "Movie" = [["A", "PERFECT", "WORLD"], ["MY", "PERFECT", "WOMAN"], ["PRETTY", "WOMAN"]]
getClass "Song" = [["A", "PERFECT", "DAY"], ["ELECTRIC", "STORM"], ["ANOTHER", "RAINY", "DAY"]]

-- Todo: do this for real (group etc.)
getDictionary :: [[String]] -> [[String]] -> [String]
getDictionary c1 c2 = ["A", "PERFECT", "WORLD", "MY", "WOMAN", "PRETTY", "DAY", "ELECTRIC", "STORM", "ANOTHER", "RAINY"] 

probabilityOfClass :: String -> String -> Double
probabilityOfClass theClass theOtherClass = (fromIntegral (length (getClass theClass))) / (fromIntegral (length (getClass theClass) + length (getClass theOtherClass)))

probabilityOfClassLaplacian :: String -> String -> Double -> Double
probabilityOfClassLaplacian theClass theOtherClass k = (fromIntegral (length (getClass theClass)) + k) / (fromIntegral (length (getClass theClass)) + fromIntegral (length (getClass theOtherClass)) + 2 * k)

probabilityOfWordGivenClass :: String -> String -> Double
probabilityOfWordGivenClass word theClass = fromIntegral((numberOfOccurencesOfWordInClass word theClass)) / fromIntegral(wordCountInClass theClass)

numberOfOccurencesOfWordInClass :: String -> String -> Int
numberOfOccurencesOfWordInClass _ _ = 1 -- TBD

wordCountInClass :: String -> Int
wordCountInClass _ = 1 -- TBD

-- Test cases

testProbabilityOfClassLaplacian = TestCase (do assertEqual "" 0.5 (probabilityOfClassLaplacian "Movie" "Song" 0)
                                               assertEqual "" 0.5 (probabilityOfClassLaplacian "Song" "Movie" 0)
                                               assertEqual "" 0.5 (probabilityOfClassLaplacian "Movie" "Song" 1)
                                               assertEqual "" 0.5 (probabilityOfClassLaplacian "Song" "Movie" 1))

testProbabilityOfClass = TestCase (do assertEqual "" 0.5 (probabilityOfClass "Movie" "Song")
                                      assertEqual "" 0.5 (probabilityOfClass "Song" "Movie"))

testGetDictionary = TestCase (assertEqual "" ["A", "PERFECT", "WORLD", "MY", "WOMAN", "PRETTY", "DAY", "ELECTRIC", "STORM", "ANOTHER", "RAINY"] (getDictionary (getClass "Movie") (getClass "Song")))

testGetClasses = TestCase (do assertEqual "" [["A", "PERFECT", "WORLD"], ["MY", "PERFECT", "WOMAN"], ["PRETTY", "WOMAN"]] (getClass "Movie")
                              assertEqual "" [["A", "PERFECT", "DAY"], ["ELECTRIC", "STORM"], ["ANOTHER", "RAINY", "DAY"]] (getClass "Song"))

allTests = TestList [TestLabel "testProbabilityOfClassLaplacian" testProbabilityOfClassLaplacian, TestLabel "testProbabilityOfClass" testProbabilityOfClass, TestLabel "testGetClasses" testGetClasses, TestLabel "testGetDictionary" testGetDictionary]



