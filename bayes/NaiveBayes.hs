-- NaiveBayes.hs
-- Naive Bayes classification.
-- © 2011 Daniel Hjort

import HUnit

-- Functions

getClass :: String -> [[String]]
getClass "Movie" = [["A", "PERFECT", "WORLD"], ["MY", "PERFECT", "WOMAN"], ["PRETTY", "WOMAN"]]
getClass "Song" = [["A", "PERFECT", "DAY"], ["ELECTRIC", "STORM"], ["ANOTHER", "RAINY", "DAY"]]

-- Todo: do this for real
getDictionary :: [[String]] -> [[String]] -> [String]
getDictionary c1 c2 = ["A", "PERFECT", "WORLD", "MY", "WOMAN", "PRETTY", "DAY", "ELECTRIC", "STORM", "ANOTHER", "RAINY"] 

probabilityOfClass :: String -> String -> Double
probabilityOfClass theClass theOtherClass = (fromIntegral (length (getClass theClass))) / (fromIntegral (length (getClass theClass) + length (getClass theOtherClass)))

probabilityOfClassLaplacian :: String -> String -> Double -> Double
probabilityOfClassLaplacian theClass theOtherClass k = (fromIntegral (length (getClass theClass)) + k) / (fromIntegral (length (getClass theClass)) + fromIntegral (length (getClass theOtherClass)) + 2 * k)

probabilityOfWordGivenClass :: String -> String -> Double
probabilityOfWordGivenClass word theClass = fromIntegral((numberOfOccurencesOfWordInClass word theClass)) / fromIntegral(wordCountInClass theClass)

probabilityOfWordGivenClassLaplacian :: String -> String -> Double -> Double
probabilityOfWordGivenClassLaplacian word theClass k = (fromIntegral(numberOfOccurencesOfWordInClass word theClass) + k)
                                                       / (fromIntegral(wordCountInClass theClass) + 
                                                       k * fromIntegral(length (getDictionary (getClass "Movie") (getClass "Song"))))

-- Todo: do this for real
numberOfOccurencesOfWordInClass :: String -> String -> Int
numberOfOccurencesOfWordInClass "PERFECT" "Movie" = 2
numberOfOccurencesOfWordInClass "PERFECT" "Song" = 1
numberOfOccurencesOfWordInClass "STORM" "Movie" = 0
numberOfOccurencesOfWordInClass "STORM" "Song" = 1

-- Todo: do this for real
wordCountInClass :: String -> Int
wordCountInClass "Movie" = 8
wordCountInClass "Song" = 8
-- wordCountInClass theClass = sum [[1 | _ <- cl] | cl <- getClass theClass] 

probabilityOfTitle :: (String, String) -> Double -> Double
probabilityOfTitle (f, s) k = (probabilityOfWordGivenClassLaplacian f "Movie" k) * (probabilityOfWordGivenClassLaplacian s "Movie" k) * (probabilityOfClassLaplacian "Movie" "Song" k) +
                           (probabilityOfWordGivenClassLaplacian f "Song" k) * (probabilityOfWordGivenClassLaplacian s "Song" k) * (probabilityOfClassLaplacian "Song" "Movie" k)

probabilityOfTitleGivenClass :: (String, String) -> String -> Double -> Double
probabilityOfTitleGivenClass (f, s) c k =  (probabilityOfWordGivenClassLaplacian f c k) * (probabilityOfWordGivenClassLaplacian s c k) 

probabilityOfClassGivenTitle :: String -> String -> (String, String) -> Double -> Double
probabilityOfClassGivenTitle c oc (f, s) k = ((probabilityOfTitleGivenClass (f, s) c k) * (probabilityOfClassLaplacian c oc k)) /
                                             (probabilityOfTitle (f, s) k)

-- Test cases

testProbabilityOfClassGivenTitle = TestCase (assertEqual "" (3/7) (probabilityOfClassGivenTitle "Movie" "Song" ("PERFECT", "STORM") 1))

testProbabilityOfTitleGivenClass = TestCase (assertEqual "" (3/361) (probabilityOfTitleGivenClass ("PERFECT", "STORM") "Movie" 1))

testProbabilityOfTitle = TestCase (assertEqual "" (7/722) (probabilityOfTitle ("PERFECT", "STORM") 1))

testProbabilityOfWordGivenClassLaplacian = TestCase (do assertEqual "" (1/19) (probabilityOfWordGivenClassLaplacian "STORM" "Movie" 1)
                                                        assertEqual "" (2/19) (probabilityOfWordGivenClassLaplacian "STORM" "Song" 1)
                                                        assertEqual "" (3/19) (probabilityOfWordGivenClassLaplacian "PERFECT" "Movie" 1)
                                                        assertEqual "" (2/19) (probabilityOfWordGivenClassLaplacian "PERFECT" "Song" 1)
                                                        assertEqual "" (1/4) (probabilityOfWordGivenClassLaplacian "PERFECT" "Movie" 0)
                                                        assertEqual "" (1/8) (probabilityOfWordGivenClassLaplacian "PERFECT" "Song" 0))

testProbabilityOfWordGivenClass = TestCase (assertEqual "" 0.25 (probabilityOfWordGivenClass "PERFECT" "Movie"))

testNumberOfOccurencesOfWordInClass = TestCase (assertEqual "" 2 (numberOfOccurencesOfWordInClass "PERFECT" "Movie"))

testWordCountInClass = TestCase (assertEqual "" 8 (wordCountInClass "Movie"))

testProbabilityOfClassLaplacian = TestCase (do assertEqual "" 0.5 (probabilityOfClassLaplacian "Movie" "Song" 0)
                                               assertEqual "" 0.5 (probabilityOfClassLaplacian "Song" "Movie" 0)
                                               assertEqual "" 0.5 (probabilityOfClassLaplacian "Movie" "Song" 1)
                                               assertEqual "" 0.5 (probabilityOfClassLaplacian "Song" "Movie" 1))

testProbabilityOfClass = TestCase (do assertEqual "" 0.5 (probabilityOfClass "Movie" "Song")
                                      assertEqual "" 0.5 (probabilityOfClass "Song" "Movie"))

testGetDictionary = TestCase (assertEqual "" ["A", "PERFECT", "WORLD", "MY", "WOMAN", "PRETTY", "DAY", "ELECTRIC", "STORM", "ANOTHER", "RAINY"] (getDictionary (getClass "Movie") (getClass "Song")))

testGetClasses = TestCase (do assertEqual "" [["A", "PERFECT", "WORLD"], ["MY", "PERFECT", "WOMAN"], ["PRETTY", "WOMAN"]] (getClass "Movie")
                              assertEqual "" [["A", "PERFECT", "DAY"], ["ELECTRIC", "STORM"], ["ANOTHER", "RAINY", "DAY"]] (getClass "Song"))

allTests = TestList [TestLabel "testProbabilityOfClassGivenTitle" testProbabilityOfClassGivenTitle,
                     TestLabel "testProbabilityOfTitleGivenClass" testProbabilityOfTitleGivenClass,
                     TestLabel "testProbabilityOfTitle" testProbabilityOfTitle,
                     TestLabel "testProbabilityOfWordGivenClassLaplacian" testProbabilityOfWordGivenClassLaplacian,
                     TestLabel "testProbabilityOfWordGivenClass" testProbabilityOfWordGivenClass,
                     TestLabel "testNumberOfOccurencesOfWordInClass" testNumberOfOccurencesOfWordInClass,
                     TestLabel "testWordCountInClass" testWordCountInClass,
                     TestLabel "testProbabilityOfClassLaplacian" testProbabilityOfClassLaplacian,
                     TestLabel "testProbabilityOfClass" testProbabilityOfClass,
                     TestLabel "testGetClasses" testGetClasses,
                     TestLabel "testGetDictionary" testGetDictionary]



