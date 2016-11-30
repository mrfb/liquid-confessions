//Jonah Uyyek
//Markov Chain Test

String[] terminals = {};
String[] startWords = {};
String[] words1 = {}; // stores every word, including duplicates
String[] words2 = {}; // stores every word only once
  Word[] words3 = {}; //stores Word objects that include the string and the list of next words, no duplicates

String[] corpus = {

  "Well, first of all, it’s so great to be with you and thank you, everybody.",
  "The Supreme Court, it is what it is all about.",
  "Our country is so, so, it is just so imperative that we have the right justices.",
  "Something happened recently where Justice Ginsburg made some very inappropriate statements toward me and toward a tremendous number of people.",
  "Many, many millions of people that I represent and she was forced to apologize.",
  "And apologize she did.",
  "But these were statements that should never, ever have been made.",
  "We need a Supreme Court that in my opinion is going to uphold the second amendment and all amendments, but the second amendment which is under absolute siege.",
  "I believe, if my opponent should win this race, which I truly don't think will happen, we will have a second amendment which will be a very, very small replica of what it is right now.",
  "But I feel that it is absolutely important that we uphold because of the fact that it is under such trauma.",
  "I feel that the justices that I am going to appoint, and I've named 20 of them.",
  "The justices that I am going to appoint will be pro-life.",
  "They will have a conservative bent.",
  "They will be protecting the second amendment.",
  "They are great scholars in all cases and they're people of tremendous respect.",
  "They will interpret the constitution the way the founders wanted it interpreted and I believe that’s very important.",
  "I don't think we should have justices appointed that decide what they want to hear.",
  "It is all about the constitution of, and it is so important.",
  "The constitution the way it was meant to be.",
  "And those are the people that I will appoint.",
  "Well the D.C. versus Heller decision was very strongly... and she was extremely angry about it.",
  "I watched.",
  "I mean, she was very, very angry when upheld.",
  "And Justice Scalia was so involved and it was a well crafted decision.",
  "But Hillary was extremely upset.",
  "And people that believe in the second amendment and believe in it very strongly were very upset with what she had to say.",
  "Well, let me just tell you before we go any further, in Chicago, which has the toughest gun laws in the United States, probably you could say by far, they have more gun violence than any other city.",
  "And I don't know if Hillary was saying it in a sarcastic manner but I'm very proud to have the endorsement of the NRA and it was the earliest endorsement they've ever given to anybody who ran for president.",
  "Well, if that would happen, because I am pro-life and I will be appointing pro-life judges, I would think that would go back to the individual states.",

};

class Word{
  String word;
  String[] nextWords = {};
  Word(String S){
    word = S;
  }
 
  
}

void setup(){
  
  size(1000,1000);
  fill(0);
  textSize(32);
  
  for(int i = 0; i < corpus.length; i++){
  
   String[] temp = corpus[i].split(" ");
   terminals = append(terminals,temp[temp.length - 1]);
   startWords = append(startWords,temp[0]);
   words1 = concat(words1, temp);
  
  }
  // array testing
  /*for(int j = 0; j < terminals.length; j++){
    println(terminals[j]); 
  }*/
  
  // if the word is not already in words2, put it there
  for(int k = 0; k < words1.length; k++){
    if(!wordSearch(words2, words1[k])){
     words2 = append(words2, words1[k]); 
    }
  }
  
  // create Word objects in word3 for each element of word2
  for(int l = 0; l < words2.length; l++){
    Word temp = new Word(words2[l]);
    words3 = (Word[])append(words3, temp);
  }
  
  // fill each Word object with its nextWords array
  for(int m = 0; m < words3.length; m++){                                // iterate over each unique Word object
    for(int n = 0; n < words1.length; n++){                              // for each Word, iterate over the entire corpus
      if(words1[n].equals(words3[m].word) && n != words1.length - 1){    // and, each time that Word appears, add the next word to its nextWords array
       words3[m].nextWords = append(words3[m].nextWords, words1[n+1]);
      }
    }
  }
  
  String[] finalstrings = generate();
  String outcome = join(finalstrings, " ");
  //println(outcome);
  text(outcome, 50, 50, 900, 900);
}

// checks to see if a certain string (subject) is in a given array. Used to keep duplicates out of words2.
boolean wordSearch(String[] list, String subject){
  for(int i = 0; i < list.length; i++){
    if(list[i].equals(subject)) return true;
  }
  return false;  
}

// checks to see if a Word object containing the string subject is in a given array, returns the index of that Word in the array. Returns -1 if not found.
int objectWordSearch(Word[] list, String subject){
  for(int i = 0; i < list.length; i++){
    if(list[i].word.equals(subject)) return i;
  }
  return -1;
}

String[] generate(){
  
  int initial = (int)random(0, startWords.length-1);
  String[] result = {};
  String parent = startWords[initial];
  //parent = "individual";
  String child;
  
  boolean cont = true;
  int index;
  int wordNum;  
  int endTest;

  result = append(result, parent);
  println("Test: " + result[0]);
  
  while(cont){
    
    if(wordSearch(terminals, parent)){
      initial = (int)random(0, startWords.length-1);
      parent = startWords[initial];
      result = append(result, parent);
    }
    
    index = objectWordSearch(words3, parent); 
    
    // error testing
    // -----------------------------------------------------------
    print("index " + index + ": "); 
    println(words3[index].word + " | " + result[0]);
    for(int s = 0; s < words3[index].nextWords.length; s++){
      println(words3[index].nextWords[s]);
    }
    if(index == -1) println("Error");
    // -----------------------------------------------------------
    
    wordNum = round(random(0, words3[index].nextWords.length - 1));
    child = words3[index].nextWords[wordNum];
    result = append(result, child);
    parent = child;
    
    if(wordSearch(terminals, parent)){
      
      // modify these values to change the chance of the string ending.
      endTest = (int)random(1, 10);
      if(endTest > 8) cont = false;
    }
  }
  for(int x = 0; x < result.length; x++) println("Test 2: " + result[x]);
  return result;
}