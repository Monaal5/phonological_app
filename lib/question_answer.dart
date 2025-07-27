

class Question {
  final String question;
  final String answer;

  final List<String>? allowAnyAnswer;
  Question({required this.question, required this.answer, this.allowAnyAnswer});
}
late List<Question> questions;


List<Question> buildSegmentQuestions() {
  return [
    // Basic segmenting
    Question(
      question: "What sounds do you hear in cat?",
      answer: "c a t",
      allowAnyAnswer: ["c a t", "cat", "c at", "ca t"],
    ),
    Question(
      question: "What sounds do you hear in dog?",
      answer: "d o g",
      allowAnyAnswer: ["d o g", "dog", "d og", "do g"],
    ),
    Question(
      question: "What sounds do you hear in sun?",
      answer: "s u n",
      allowAnyAnswer: ["s u n", "sun", "s un", "su n"],
    ),
    Question(
      question: "What sounds do you hear in hat?",
      answer: "h a t",
      allowAnyAnswer: ["h a t", "hat", "h at", "ha t"],
    ),
    Question(
      question: "What sounds do you hear in run?",
      answer: "r u n",
      allowAnyAnswer: ["r u n", "run", "r un", "ru n"],
    ),
    // Different question formats
    Question(
      question: "Say each sound in big.",
      answer: "b i g",
      allowAnyAnswer: ["b i g", "big", "b ig", "bi g"],
    ),
    Question(
      question: "Break down the word red into sounds.",
      answer: "r e d",
      allowAnyAnswer: ["r e d", "red", "r ed", "re d"],
    ),
    Question(
      question: "What are the sounds in blue?",
      answer: "b l ue",
      allowAnyAnswer: ["b l ue", "blue", "b lue", "bl ue"],
    ),
    Question(
      question: "Segment the word green.",
      answer: "g r ee n",
      allowAnyAnswer: ["g r ee n", "green", "g reen", "gr een"],
    ),
    Question(
      question: "Tell me the sounds in black.",
      answer: "b l a ck",
      allowAnyAnswer: ["b l a ck", "black", "b lack", "bl ack"],
    ),
    // More complex words
    Question(
      question: "What sounds do you hear in white?",
      answer: "wh i t",
      allowAnyAnswer: ["wh i t", "white", "wh ite", "whi te"],
    ),
    Question(
      question: "Say each sound in brown.",
      answer: "b r ow n",
      allowAnyAnswer: ["b r ow n", "brown", "b rown", "br own"],
    ),
    Question(
      question: "What sounds are in pink?",
      answer: "p i nk",
      allowAnyAnswer: ["p i nk", "pink", "p ink", "pi nk"],
    ),
    Question(
      question: "Break down purple into sounds.",
      answer: "p ur p l",
      allowAnyAnswer: ["p ur p l", "purple", "p urple", "pur ple"],
    ),
    Question(
      question: "What sounds do you hear in orange?",
      answer: "or a nge",
      allowAnyAnswer: ["or a nge", "orange", "or ange", "ora nge"],
    ),
    // Different instruction styles
    Question(
      question: "Segment the word yellow.",
      answer: "y e ll ow",
      allowAnyAnswer: ["y e ll ow", "yellow", "y ellow", "ye llow"],
    ),
    Question(
      question: "What sounds make up book?",
      answer: "b oo k",
      allowAnyAnswer: ["b oo k", "book", "b ook", "bo ok"],
    ),
    Question(
      question: "Say each sound in ball.",
      answer: "b a ll",
      allowAnyAnswer: ["b a ll", "ball", "b all", "ba ll"],
    ),
    Question(
      question: "What sounds do you hear in fish?",
      answer: "f i sh",
      allowAnyAnswer: ["f i sh", "fish", "f ish", "fi sh"],
    ),
    Question(
      question: "Break down tree into sounds.",
      answer: "t r ee",
      allowAnyAnswer: ["t r ee", "tree", "t ree", "tr ee"],
    ),
    // More variety
    Question(
      question: "What sounds are in moon?",
      answer: "m oo n",
      allowAnyAnswer: ["m oo n", "moon", "m oon", "mo on"],
    ),
    Question(
      question: "Segment the word star.",
      answer: "s t ar",
      allowAnyAnswer: ["s t ar", "star", "s tar", "st ar"],
    ),
    Question(
      question: "What sounds do you hear in car?",
      answer: "c ar",
      allowAnyAnswer: ["c ar", "car", "c ar"],
    ),
    Question(
      question: "Say each sound in house.",
      answer: "h ow s",
      allowAnyAnswer: ["h ow s", "house", "h ouse", "ho use"],
    ),
    Question(
      question: "What sounds make up mouse?",
      answer: "m ow s",
      allowAnyAnswer: ["m ow s", "mouse", "m ouse", "mo use"],
    ),
    Question(
      question: "Break down cake into sounds.",
      answer: "c a k",
      allowAnyAnswer: ["c a k", "cake", "c ake", "ca ke"],
    ),
    Question(
      question: "What sounds do you hear in bike?",
      answer: "b i k",
      allowAnyAnswer: ["b i k", "bike", "b ike", "bi ke"],
    ),
    Question(
      question: "Segment the word boat.",
      answer: "b oa t",
      allowAnyAnswer: ["b oa t", "boat", "b oat", "bo at"],
    ),
    Question(
      question: "What sounds are in rain?",
      answer: "r ai n",
      allowAnyAnswer: ["r ai n", "rain", "r ain", "ra in"],
    ),
    Question(
      question: "Say each sound in train.",
      answer: "t r ai n",
      allowAnyAnswer: ["t r ai n", "train", "t rain", "tr ain"],
    ),
    Question(
      question: "What sounds do you hear in bird?",
      answer: "b ir d",
      allowAnyAnswer: ["b ir d", "bird", "b ird", "bi rd"],
    ),
    Question(
      question: "Break down word into sounds.",
      answer: "w or d",
      allowAnyAnswer: ["w or d", "word", "w ord", "wo rd"],
    ),
    Question(
      question: "What sounds make up light?",
      answer: "l i gh t",
      allowAnyAnswer: ["l i gh t", "light", "l ight", "li ght"],
    ),
    Question(
      question: "Segment the word night.",
      answer: "n i gh t",
      allowAnyAnswer: ["n i gh t", "night", "n ight", "ni ght"],
    ),
    Question(
      question: "What sounds do you hear in day?",
      answer: "d ay",
      allowAnyAnswer: ["d ay", "day", "d ay"],
    ),
    Question(
      question: "Say each sound in way.",
      answer: "w ay",
      allowAnyAnswer: ["w ay", "way", "w ay"],
    ),
    Question(
      question: "What sounds are in fun?",
      answer: "f u n",
      allowAnyAnswer: ["f u n", "fun", "f un", "fu n"],
    ),
    Question(
      question: "Break down bun into sounds.",
      answer: "b u n",
      allowAnyAnswer: ["b u n", "bun", "b un", "bu n"],
    ),
    Question(
      question: "What sounds do you hear in pig?",
      answer: "p i g",
      allowAnyAnswer: ["p i g", "pig", "p ig", "pi g"],
    ),
    Question(
      question: "Segment the word bed.",
      answer: "b e d",
      allowAnyAnswer: ["b e d", "bed", "b ed", "be d"],
    ),
    Question(
      question: "What sounds make up shoe?",
      answer: "sh oe",
      allowAnyAnswer: ["sh oe", "shoe", "sh oe"],
    ),
    Question(
      question: "Say each sound in bean.",
      answer: "b ea n",
      allowAnyAnswer: ["b ea n", "bean", "b ean", "be an"],
    ),
    Question(
      question: "What sounds do you hear in fellow?",
      answer: "f e ll ow",
      allowAnyAnswer: ["f e ll ow", "fellow", "f ellow", "fe llow"],
    ),
    Question(
      question: "Break down sack into sounds.",
      answer: "s a ck",
      allowAnyAnswer: ["s a ck", "sack", "s ack", "sa ck"],
    ),
    Question(
      question: "What sounds are in kite?",
      answer: "k i t",
      allowAnyAnswer: ["k i t", "kite", "k ite", "ki te"],
    ),
    Question(
      question: "Segment the word clown.",
      answer: "c l ow n",
      allowAnyAnswer: ["c l ow n", "clown", "c lown", "cl own"],
    ),
    Question(
      question: "What sounds do you hear in sink?",
      answer: "s i nk",
      allowAnyAnswer: ["s i nk", "sink", "s ink", "si nk"],
    ),
    Question(
      question: "Break down turtle into sounds.",
      answer: "t ur t l",
      allowAnyAnswer: ["t ur t l", "turtle", "t urtle", "tu rtle"],
    ),
    Question(
      question: "What sounds make up door hinge?",
      answer: "d oor h i nge",
      allowAnyAnswer: ["d oor h i nge", "door hinge", "d oorhinge", "doo rhinge"],
    ),
  ];
}


List<Question> buildSyllableQuestions() {
  return [
    // Counting questions
    Question(
      question: "How many syllables are in the word apple?",
      answer: "two",
      allowAnyAnswer: ["2", "two", "2 syllables", "two syllables"],
    ),
    Question(
      question: "How many syllables are in the word tiger?",
      answer: "two",
      allowAnyAnswer: ["2", "two", "2 syllables", "two syllables"],
    ),
    Question(
      question: "How many syllables are in the word elephant?",
      answer: "three",
      allowAnyAnswer: ["3", "three", "3 syllables", "three syllables"],
    ),
    Question(
      question: "How many syllables are in the word butterfly?",
      answer: "three",
      allowAnyAnswer: ["3", "three", "3 syllables", "three syllables"],
    ),
    Question(
      question: "How many syllables are in the word computer?",
      answer: "three",
      allowAnyAnswer: ["3", "three", "3 syllables", "three syllables"],
    ),
    // Clapping questions
    Question(
      question: "Clap the syllables in rainbow.",
      answer: "rain bow",
      allowAnyAnswer: ["rain bow", "rainbow", "2", "two"],
    ),
    Question(
      question: "Clap the syllables in sunshine.",
      answer: "sun shine",
      allowAnyAnswer: ["sun shine", "sunshine", "2", "two","sun sign","sun sine"],
    ),
    Question(
      question: "Clap the syllables in basketball.",
      answer: "basket ball",
      allowAnyAnswer: ["basket ball", "basketball", "3", "three"],
    ),
    Question(
      question: "Clap the syllables in telephone.",
      answer: "tel e phone",
      allowAnyAnswer: ["tel e phone", "telephone", "3", "three"],
    ),
    Question(
      question: "Clap the syllables in dinosaur.",
      answer: "di no saur",
      allowAnyAnswer: ["di no saur", "dinosaur", "3", "three"],
    ),
    // Multiple choice
    Question(
      question: "Which word has 3 syllables? a) apple b) elephant c) dog",
      answer: "elephant",
    ),
    Question(
      question: "Which word has 2 syllables? a) cat b) tiger c) hippopotamus",
      answer: "tiger",
    ),
    Question(
      question: "Which word has 4 syllables? a) butterfly b) helicopter c) dog",
      answer: "helicopter",
    ),
    // More variety
    Question(
      question: "How many syllables in watermelon?",
      answer: "four",
      allowAnyAnswer: ["4", "four", "4 syllables", "four syllables"],
    ),
    Question(
      question: "Clap the syllables in strawberry.",
      answer: "straw ber ry",
      allowAnyAnswer: ["straw ber ry", "strawberry", "3", "three"],
    ),
    Question(
      question: "How many syllables in chocolate?",
      answer: "two",
      allowAnyAnswer: ["2", "two", "2 syllables", "two syllables"],
    ),
    Question(
      question: "Which word has 2 syllables? a) pineapple b) cat c) crocodile",
      answer: "pineapple",
    ),
    Question(
      question: "Clap the syllables in kangaroo.",
      answer: "kan ga roo",
      allowAnyAnswer: ["kan ga roo", "kangaroo", "3", "three"],
    ),
    Question(
      question: "How many syllables in hippopotamus?",
      answer: "five",
      allowAnyAnswer: ["5", "five", "5 syllables", "five syllables"],
    ),
    Question(
      question: "Which word has 3 syllables? a) octopus b) dog c) cat",
      answer: "octopus",
    ),
    Question(
      question: "Clap the syllables in penguin.",
      answer: "pen guin",
      allowAnyAnswer: ["pen guin", "penguin", "2", "two"],
    ),
    Question(
      question: "How many syllables in dolphin?",
      answer: "two",
      allowAnyAnswer: ["2", "two", "2 syllables", "two syllables"],
    ),
    Question(
      question: "Which word has 3 syllables? a) flamingo b) bird c) fish",
      answer: "flamingo",
    ),
    Question(
      question: "Clap the syllables in ladybug.",
      answer: "la dy bug",
      allowAnyAnswer: ["la dy bug", "ladybug", "3", "three"],
    ),
    Question(
      question: "How many syllables in grasshopper?",
      answer: "three",
      allowAnyAnswer: ["3", "three", "3 syllables", "three syllables"],
    ),
    Question(
      question: "Which word has 4 syllables? a) caterpillar b) ant c) bee",
      answer: "caterpillar",
    ),
    Question(
      question: "Clap the syllables in firefly.",
      answer: "fire fly",
      allowAnyAnswer: ["fire fly", "firefly", "2", "two"],
    ),
    Question(
      question: "How many syllables in dragonfly?",
      answer: "three",
      allowAnyAnswer: ["3", "three", "3 syllables", "three syllables"],
    ),
    Question(
      question: "Which word has 3 syllables? a) bumblebee b) bee c) wasp",
      answer: "bumblebee",
    ),
    Question(
      question: "Clap the syllables in honeybee.",
      answer: "hon ey bee",
      allowAnyAnswer: ["hon ey bee", "honeybee", "3", "three"],
    ),
    Question(
      question: "How many syllables in sunflower?",
      answer: "three",
      allowAnyAnswer: ["3", "three", "3 syllables", "three syllables"],
    ),
    Question(
      question: "Which word has 3 syllables? a) daffodil b) rose c) tulip",
      answer: "daffodil",
    ),
    Question(
      question: "Clap the syllables in tulip.",
      answer: "tu lip",
      allowAnyAnswer: ["tu lip", "tulip", "2", "two"],
    ),
    Question(
      question: "How many syllables in rose?",
      answer: "one",
      allowAnyAnswer: ["1", "one", "1 syllable", "one syllable"],
    ),
    Question(
      question: "Which word has 2 syllables? a) lily b) marigold c) daisy",
      answer: "marigold",
    ),
    Question(
      question: "Clap the syllables in daisy.",
      answer: "dai sy",
      allowAnyAnswer: ["dai sy", "daisy", "2", "two"],
    ),
    Question(
      question: "How many syllables in pansy?",
      answer: "two",
      allowAnyAnswer: ["2", "two", "2 syllables", "two syllables"],
    ),
    Question(
      question: "Which word has 3 syllables? a) petunia b) iris c) aster",
      answer: "petunia",
    ),
    Question(
      question: "Clap the syllables in zinnia.",
      answer: "zin ni a",
      allowAnyAnswer: ["zin ni a", "zinnia", "3", "three"],
    ),
    Question(
      question: "How many syllables in aster?",
      answer: "two",
      allowAnyAnswer: ["2", "two", "2 syllables", "two syllables"],
    ),
    Question(
      question: "Which word has 2 syllables? a) iris b) orchid c) carnation",
      answer: "iris",
    ),
    Question(
      question: "Clap the syllables in orchid.",
      answer: "or chid",
      allowAnyAnswer: ["or chid", "orchid", "2", "two"],
    ),
    Question(
      question: "How many syllables in carnation?",
      answer: "three",
      allowAnyAnswer: ["3", "three", "3 syllables", "three syllables"],
    ),
    Question(
      question: "Which word has 5 syllables? a) chrysanthemum b) begonia c) geranium",
      answer: "chrysanthemum",
    ),
    Question(
      question: "Clap the syllables in begonia.",
      answer: "be go ni a",
      allowAnyAnswer: ["be go ni a", "begonia", "4", "four"],
    ),
    Question(
      question: "How many syllables in geranium?",
      answer: "four",
      allowAnyAnswer: ["4", "four", "4 syllables", "four syllables"],
    ),
    Question(
      question: "Which word has 4 syllables? a) impatiens b) snapdragon c) rose",
      answer: "impatiens",
    ),
    Question(
      question: "Clap the syllables in snapdragon.",
      answer: "snap drag on",
      allowAnyAnswer: ["snap drag on", "snapdragon", "3", "three"],
    ),
  ];
}


List<Question> buildRhymingQuestions() {
  return [
    // Recognition
    Question(
      question: "Which word rhymes with cat? a) dog  b) mat  c) fish",
      answer: "mat",
    ),
    Question(
      question: "Which word rhymes with log? a) frog  b) sun  c) car",
      answer: "frog",
    ),
    Question(
      question: "Which word rhymes with star? a) car  b) book  c) tree",
      answer: "car",
    ),
    Question(
      question: "Which word rhymes with cake? a) bike  b) lake  c) sun",
      answer: "lake",
    ),
    // Production
    Question(
      question: "Tell me a word that rhymes with dog.",
      answer: "log",
      allowAnyAnswer: ["fog", "hog", "jog", "frog", "bog", "cog", "log"],
    ),
    Question(
      question: "Say a word that rhymes with sun.",
      answer: "fun",
      allowAnyAnswer: ["fun", "run", "bun", "none", "done", "gun"],
    ),
    Question(
      question: "Can you think of a word that rhymes with tree?",
      answer: "bee",
      allowAnyAnswer: ["bee", "see", "free", "three", "knee", "flee", "key"],
    ),
    // Rhyme Judgment
    Question(
      question: "Do cat and hat rhyme? (yes or no)",
      answer: "yes",
    ),
    Question(
      question: "Do fish and dish rhyme? (yes or no)",
      answer: "yes",
    ),
    Question(
      question: "Do book and ball rhyme? (yes or no)",
      answer: "no",
    ),
    Question(
      question: "Do cake and bike rhyme? (yes or no)",
      answer: "no",
    ),
    // More variety
    Question(
      question: "Which of these words rhymes with 'mouse'? a) house  b) dog  c) sun",
      answer: "house",
    ),
    Question(
      question: "Say a word that rhymes with 'star'.",
      answer: "car",
      allowAnyAnswer: ["car", "bar", "far", "jar", "tar"],
    ),
    Question(
      question: "Do 'night' and 'light' rhyme? (yes or no)",
      answer: "yes",
    ),
    Question(
      question: "Which word rhymes with 'cake'? a) snake  b) sun  c) dog",
      answer: "snake",
    ),
    Question(
      question: "Tell me a word that rhymes with 'red'.",
      answer: "bed",
      allowAnyAnswer: ["bed", "head", "said", "led", "fed"],
    ),
    Question(
      question: "Do 'blue' and 'shoe' rhyme? (yes or no)",
      answer: "yes",
    ),
    Question(
      question: "Which of these words rhymes with 'fun'? a) run  b) dog  c) cat",
      answer: "run",
    ),
    Question(
      question: "Say a word that rhymes with 'pig'.",
      answer: "wig",
      allowAnyAnswer: ["wig", "big", "dig", "fig", "jig"],
    ),
    Question(
      question: "Do 'moon' and 'soon' rhyme? (yes or no)",
      answer: "yes",
    ),
    Question(
      question: "Which word rhymes with 'cake'? a) lake  b) sun  c) dog",
      answer: "lake",
    ),
  ];
}


List<Question> buildMiddleSoundQuestions() {
  return [
    // Basic middle sound questions
    Question(
      question: "What is the middle sound in cat?",
      answer: "a",
    ),
    Question(
      question: "What is the middle sound in dog?",
      answer: "o",
    ),
    Question(
      question: "What is the middle sound in sun?",
      answer: "u",
    ),
    Question(
      question: "What is the middle sound in hat?",
      answer: "a",
    ),
    Question(
      question: "What is the middle sound in run?",
      answer: "u",
    ),
    // Different question formats
    Question(
      question: "What sound is in the middle of big?",
      answer: "i",
    ),
    Question(
      question: "Say the middle sound in red.",
      answer: "e",
    ),
    Question(
      question: "What is the center sound in blue?",
      answer: "l",
    ),
    Question(
      question: "What sound comes in the middle of green?",
      answer: "r",
    ),
    Question(
      question: "What is the middle sound you hear in black?",
      answer: "l",
    ),
    // Multiple choice questions
    Question(
      question: "Which word has 'a' in the middle? a) cat b) dog c) sun",
      answer: "cat",
    ),
    Question(
      question: "Which word has 'o' in the middle? a) hat b) dog c) run",
      answer: "dog",
    ),
    Question(
      question: "Which word has 'u' in the middle? a) big b) sun c) red",
      answer: "sun",
    ),
    // More variety
    Question(
      question: "What is the middle sound in white?",
      answer: "i",
    ),
    Question(
      question: "What sound is in the middle of brown?",
      answer: "r",
    ),
    Question(
      question: "Say the middle sound in pink.",
      answer: "i",
    ),
    Question(
      question: "What is the center sound in purple?",
      answer: "ur",
    ),
    Question(
      question: "What sound comes in the middle of orange?",
      answer: "a",
    ),
    Question(
      question: "What is the middle sound you hear in yellow?",
      answer: "e",
    ),
    Question(
      question: "What sound is in the middle of book?",
      answer: "oo",
    ),
    Question(
      question: "Say the middle sound in ball.",
      answer: "a",
    ),
    Question(
      question: "What is the center sound in fish?",
      answer: "i",
    ),
    Question(
      question: "What sound comes in the middle of tree?",
      answer: "r",
    ),
    Question(
      question: "What is the middle sound you hear in moon?",
      answer: "oo",
    ),
    Question(
      question: "What sound is in the middle of star?",
      answer: "t",
    ),
    Question(
      question: "Say the middle sound in car.",
      answer: "a",
    ),
    Question(
      question: "What is the center sound in house?",
      answer: "ow",
    ),
    Question(
      question: "What sound comes in the middle of mouse?",
      answer: "ow",
    ),
    Question(
      question: "What is the middle sound you hear in cake?",
      answer: "a",
    ),
    Question(
      question: "What sound is in the middle of bike?",
      answer: "i",
    ),
    Question(
      question: "Say the middle sound in boat.",
      answer: "oa",
    ),
    Question(
      question: "What is the center sound in rain?",
      answer: "ai",
    ),
    Question(
      question: "What sound comes in the middle of train?",
      answer: "ai",
    ),
    Question(
      question: "What is the middle sound you hear in bird?",
      answer: "ir",
    ),
    Question(
      question: "What sound is in the middle of word?",
      answer: "or",
    ),
    Question(
      question: "Say the middle sound in light.",
      answer: "i",
    ),
    Question(
      question: "What is the center sound in night?",
      answer: "i",
    ),
    Question(
      question: "What sound comes in the middle of day?",
      answer: "a",
    ),
    Question(
      question: "What is the middle sound you hear in way?",
      answer: "a",
    ),
    Question(
      question: "What sound is in the middle of fun?",
      answer: "u",
    ),
    Question(
      question: "Say the middle sound in bun.",
      answer: "u",
    ),
    Question(
      question: "What is the center sound in pig?",
      answer: "i",
    ),
    Question(
      question: "What sound comes in the middle of bed?",
      answer: "e",
    ),
    Question(
      question: "What is the middle sound you hear in shoe?",
      answer: "oe",
    ),
    Question(
      question: "What sound is in the middle of bean?",
      answer: "ea",
    ),
    Question(
      question: "Say the middle sound in fellow.",
      answer: "e",
    ),
    Question(
      question: "What is the center sound in sack?",
      answer: "a",
    ),
    Question(
      question: "What sound comes in the middle of kite?",
      answer: "i",
    ),
    Question(
      question: "What is the middle sound you hear in clown?",
      answer: "ow",
    ),
    Question(
      question: "What sound is in the middle of sink?",
      answer: "i",
    ),
    Question(
      question: "Say the middle sound in turtle.",
      answer: "ur",
    ),
    Question(
      question: "What is the center sound in door hinge?",
      answer: "oor",
    ),
  ];
}


List<Question> buildInitialSoundQuestions() {
  return [
    // Basic initial sound questions
    Question(
      question: "What is the first sound in cat?",
      answer: "ka",
    ),
    Question(
      question: "What is the first sound in dog?",
      answer: "d",
    ),


    Question(
      question: "What is the first sound in hat?",
      answer: "ha",
    ),
    Question(
      question: "What is the first sound in run?",
      answer: "r",
    ),
    // Different question formats
    Question(
      question: "What sound does big start with?",
      answer: "b",
    ),
    Question(
      question: "Say the first sound in red.",
      answer: "r",
    ),
    Question(
      question: "What is the beginning sound in blue?",
      answer: "b",
    ),
    Question(
      question: "What sound comes first in green?",
      answer: "g",
    ),
    Question(
      question: "What is the first sound you hear in black?",
      answer: "b",
    ),
    // Multiple choice questions
    Question(
      question: "Which word starts with 'c'? a) cat b) dog c) sun",
      answer: "cat",
    ),
    Question(
      question: "Which word starts with 'd'? a) hat b) dog c) run",
      answer: "dog",
    ),
    Question(
      question: "Which word starts with 's'? a) big b) sun c) red",
      answer: "sun",
    ),
    // More variety
    Question(
      question: "What is the first sound in white?",
      answer: "w",
    ),
    Question(
      question: "What sound does brown start with?",
      answer: "b",
    ),
    Question(
      question: "Say the first sound in pink.",
      answer: "p",
    ),
    Question(
      question: "What is the beginning sound in purple?",
      answer: "p",
    ),
    Question(
      question: "What sound comes first in orange?",
      answer: "o",
    ),
    Question(
      question: "What is the first sound you hear in yellow?",
      answer: "y",
    ),
    Question(
      question: "What sound does book start with?",
      answer: "b",
    ),
    Question(
      question: "Say the first sound in ball.",
      answer: "b",
    ),
    Question(
      question: "What is the beginning sound in fish?",
      answer: "f",
    ),
    Question(
      question: "What sound comes first in tree?",
      answer: "t",
    ),
    Question(
      question: "What is the first sound you hear in moon?",
      answer: "m",
    ),
    Question(
      question: "What sound does star start with?",
      answer: "s",
    ),
    Question(
      question: "Say the first sound in car.",
      answer: "c",
    ),
    Question(
      question: "What is the beginning sound in house?",
      answer: "h",
    ),
    Question(
      question: "What sound comes first in mouse?",
      answer: "m",
    ),
    Question(
      question: "What is the first sound you hear in cake?",
      answer: "c",
    ),
    Question(
      question: "What sound does bike start with?",
      answer: "b",
    ),
    Question(
      question: "Say the first sound in boat.",
      answer: "b",
    ),
    Question(
      question: "What is the beginning sound in rain?",
      answer: "r",
    ),
    Question(
      question: "What sound comes first in train?",
      answer: "t",
    ),
    Question(
      question: "What is the first sound you hear in bird?",
      answer: "b",
    ),
    Question(
      question: "What sound does word start with?",
      answer: "w",
    ),
    Question(
      question: "Say the first sound in light.",
      answer: "l",
    ),
    Question(
      question: "What is the beginning sound in night?",
      answer: "n",
    ),
    Question(
      question: "What sound comes first in day?",
      answer: "d",
    ),
    Question(
      question: "What is the first sound you hear in way?",
      answer: "w",
    ),
    Question(
      question: "What sound does fun start with?",
      answer: "f",
    ),
    Question(
      question: "Say the first sound in bun.",
      answer: "b",
    ),
    Question(
      question: "What is the beginning sound in pig?",
      answer: "p",
    ),
    Question(
      question: "What sound comes first in bed?",
      answer: "b",
    ),
    Question(
      question: "What is the first sound you hear in shoe?",
      answer: "sh",
    ),
    Question(
      question: "What sound does bean start with?",
      answer: "b",
    ),
    Question(
      question: "Say the first sound in fellow.",
      answer: "f",
    ),
    Question(
      question: "What is the beginning sound in sack?",
      answer: "s",
    ),
    Question(
      question: "What sound comes first in kite?",
      answer: "k",
    ),
    Question(
      question: "What is the first sound you hear in clown?",
      answer: "c",
    ),
    Question(
      question: "What sound does sink start with?",
      answer: "s",
    ),
    Question(
      question: "Say the first sound in turtle.",
      answer: "t",
    ),
    Question(
      question: "What is the beginning sound in door hinge?",
      answer: "d",
    ),
  ];
}


List<Question> buildFinalSoundQuestions() {
  return [
    // Basic final sound questions
    Question(
      question: "What is the last sound in cat?",
      answer: "t sound",
    ),
    Question(
      question: "What is the last sound in dog?",
      answer: "g",
    ),
    Question(
      question: "What is the last sound in sun?",
      answer: "n",
    ),
    Question(
      question: "What is the last sound in hat?",
      answer: "t",
    ),
    Question(
      question: "What is the last sound in run?",
      answer: "n",
    ),
    // Different question formats
    Question(
      question: "What sound does big end with?",
      answer: "g",
    ),
    Question(
      question: "Say the last sound in red.",
      answer: "d",
    ),
    Question(
      question: "What is the ending sound in blue?",
      answer: "e",
    ),
    Question(
      question: "What sound comes last in green?",
      answer: "n",
    ),
    Question(
      question: "What is the last sound you hear in black?",
      answer: "k",
    ),
    // Multiple choice questions
    Question(
      question: "Which word ends with 't'? a) cat b) dog c) sun",
      answer: "cat",
    ),
    Question(
      question: "Which word ends with 'g'? a) hat b) dog c) run",
      answer: "dog",
    ),
    Question(
      question: "Which word ends with 'n'? a) big b) sun c) red",
      answer: "sun",
    ),
    // More variety
    Question(
      question: "What is the last sound in white?",
      answer: "t",
    ),
    Question(
      question: "What sound does brown end with?",
      answer: "n",
    ),
    Question(
      question: "Say the last sound in pink.",
      answer: "k",
    ),
    Question(
      question: "What is the ending sound in purple?",
      answer: "l",
    ),
    Question(
      question: "What sound comes last in orange?",
      answer: "e",
    ),
    Question(
      question: "What is the last sound you hear in yellow?",
      answer: "w",
    ),
    Question(
      question: "What sound does book end with?",
      answer: "k",
    ),
    Question(
      question: "Say the last sound in ball.",
      answer: "l",
    ),
    Question(
      question: "What is the ending sound in fish?",
      answer: "sh",
    ),
    Question(
      question: "What sound comes last in tree?",
      answer: "e",
    ),
    Question(
      question: "What is the last sound you hear in moon?",
      answer: "n",
    ),
    Question(
      question: "What sound does star end with?",
      answer: "r",
    ),
    Question(
      question: "Say the last sound in car.",
      answer: "r",
    ),
    Question(
      question: "What is the ending sound in house?",
      answer: "s",
    ),
    Question(
      question: "What sound comes last in mouse?",
      answer: "s",
    ),
    Question(
      question: "What is the last sound you hear in cake?",
      answer: "k",
    ),
    Question(
      question: "What sound does bike end with?",
      answer: "k",
    ),
    Question(
      question: "Say the last sound in boat.",
      answer: "t",
    ),
    Question(
      question: "What is the ending sound in rain?",
      answer: "n",
    ),
    Question(
      question: "What sound comes last in train?",
      answer: "n",
    ),
    Question(
      question: "What is the last sound you hear in bird?",
      answer: "d",
    ),
    Question(
      question: "What sound does word end with?",
      answer: "d",
    ),
    Question(
      question: "Say the last sound in light.",
      answer: "t",
    ),
    Question(
      question: "What is the ending sound in night?",
      answer: "t",
    ),
    Question(
      question: "What sound comes last in day?",
      answer: "y",
    ),
    Question(
      question: "What is the last sound you hear in way?",
      answer: "y",
    ),
    Question(
      question: "What sound does fun end with?",
      answer: "n",
    ),
    Question(
      question: "Say the last sound in bun.",
      answer: "n",
    ),
    Question(
      question: "What is the ending sound in pig?",
      answer: "g",
    ),
    Question(
      question: "What sound comes last in bed?",
      answer: "d",
    ),
    Question(
      question: "What is the last sound you hear in shoe?",
      answer: "e",
    ),
    Question(
      question: "What sound does bean end with?",
      answer: "n",
    ),
    Question(
      question: "Say the last sound in fellow.",
      answer: "w",
    ),
    Question(
      question: "What is the ending sound in sack?",
      answer: "k",
    ),
    Question(
      question: "What sound comes last in kite?",
      answer: "t",
    ),
    Question(
      question: "What is the last sound you hear in clown?",
      answer: "n",
    ),
    Question(
      question: "What sound does sink end with?",
      answer: "k",
    ),
    Question(
      question: "Say the last sound in turtle.",
      answer: "l",
    ),
    Question(
      question: "What is the ending sound in door hinge?",
      answer: "e",
    ),
  ];
}


List<Question> buildBlendingQuestions() {
  return [
    // Basic blending
    Question(
      question: "What word do these sounds make: c a t?",
      answer: "cat",
    ),
    Question(
      question: "What word do these sounds make: d o g?",
      answer: "dog",
    ),
    Question(
      question: "What word do these sounds make: s u n?",
      answer: "sun",
    ),
    Question(
      question: "What word do these sounds make: h a t?",
      answer: "hat",
    ),
    Question(
      question: "What word do these sounds make: r u n?",
      answer: "run",
    ),
    // Different question formats
    Question(
      question: "Blend these sounds: b i g",
      answer: "big",
    ),
    Question(
      question: "What word do you get when you blend: r e d?",
      answer: "red",
    ),
    Question(
      question: "Put these sounds together: b l ue",
      answer: "blue",
    ),
    Question(
      question: "What word do these sounds make: g r ee n?",
      answer: "green",
    ),
    Question(
      question: "Blend the sounds: b l a ck",
      answer: "black",
    ),
    // More complex words
    Question(
      question: "What word do these sounds make: wh i t?",
      answer: "white",
    ),
    Question(
      question: "Blend these sounds: b r ow n",
      answer: "brown",
    ),
    Question(
      question: "What word do you get when you blend: p i nk?",
      answer: "pink",
    ),
    Question(
      question: "Put these sounds together: p ur p l",
      answer: "purple",
    ),
    Question(
      question: "What word do these sounds make: or a nge?",
      answer: "orange",
    ),
    // Different instruction styles
    Question(
      question: "Blend the sounds: y e ll ow",
      answer: "yellow",
    ),
    Question(
      question: "What word do these sounds make: b oo k?",
      answer: "book",
    ),
    Question(
      question: "Put these sounds together: b a ll",
      answer: "ball",
    ),
    Question(
      question: "What word do you get when you blend: f i sh?",
      answer: "fish",
    ),
    Question(
      question: "Blend these sounds: t r ee",
      answer: "tree",
    ),
    // More variety
    Question(
      question: "What word do these sounds make: m oo n?",
      answer: "moon",
    ),
    Question(
      question: "Blend the sounds: s t ar",
      answer: "star",
    ),
    Question(
      question: "What word do you get when you blend: c ar?",
      answer: "car",
    ),
    Question(
      question: "Put these sounds together: h ow s",
      answer: "house",
    ),
    Question(
      question: "What word do these sounds make: m ow s?",
      answer: "mouse",
    ),
    Question(
      question: "Blend these sounds: c a k",
      answer: "cake",
    ),
    Question(
      question: "What word do these sounds make: b i k?",
      answer: "bike",
    ),
    Question(
      question: "Blend the sounds: b oa t",
      answer: "boat",
    ),
    Question(
      question: "What word do you get when you blend: r ai n?",
      answer: "rain",
    ),
    Question(
      question: "What word do these sounds make: t r ai n?",
      answer: "train",
    ),
    Question(
      question: "Blend these sounds: b ir d",
      answer: "bird",
    ),
    Question(
      question: "What word do these sounds make: w or d?",
      answer: "word",
    ),
    Question(
      question: "Blend the sounds: l i gh t",
      answer: "light",
    ),
    Question(
      question: "What word do you get when you blend: n i gh t?",
      answer: "night",
    ),
    Question(
      question: "What word do these sounds make: d ay?",
      answer: "day",
    ),
    Question(
      question: "Blend these sounds: w ay",
      answer: "way",
    ),
    Question(
      question: "What word do these sounds make: f u n?",
      answer: "fun",
    ),
    Question(
      question: "Blend the sounds: b u n",
      answer: "bun",
    ),
    Question(
      question: "What word do you get when you blend: p i g?",
      answer: "pig",
    ),
    Question(
      question: "What word do these sounds make: b e d?",
      answer: "bed",
    ),
    Question(
      question: "Blend these sounds: sh oe",
      answer: "shoe",
    ),
    Question(
      question: "What word do these sounds make: b ea n?",
      answer: "bean",
    ),
    Question(
      question: "Blend the sounds: f e ll ow",
      answer: "fellow",
    ),
    Question(
      question: "What word do you get when you blend: s a ck?",
      answer: "sack",
    ),
    Question(
      question: "What word do these sounds make: k i t?",
      answer: "kite",
    ),
    Question(
      question: "Blend these sounds: c l ow n",
      answer: "clown",
    ),
    Question(
      question: "What word do these sounds make: s i nk?",
      answer: "sink",
    ),
    Question(
      question: "Blend the sounds: t ur t l",
      answer: "turtle",
    ),
    Question(
      question: "What word do you get when you blend: d oor h i nge?",
      answer: "door hinge",
    ),
  ];
}