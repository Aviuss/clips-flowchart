(deftemplate pytanie
	(slot tresc (type STRING))
	(multislot opcje (type STRING))	
)

(deftemplate odpowiedz_do_pytania
	(slot tresc (type STRING))
	(slot odpowiedz (type STRING))	
)

(defrule retractpyt
    ?f <- (pytanie (tresc ?x) (opcje ?))
    (odpowiedz_do_pytania (tresc ?x) (odpowiedz ?))
=>
    (retract ?f)
)


(defrule start
=>
	(assert (pytanie (tresc "How old are you?") (opcje "0-5" "6-12" "13+")))
)

(defrule q_how_old_0_5
    (odpowiedz_do_pytania (tresc "How old are you?") (odpowiedz "0-5"))
    (not (odpowiedz_do_pytania (tresc "Are you really doing this quiz? I M P R E S S I V E! Do your parents want you to be a child prodigy?") (odpowiedz ?)))
=>
    (assert (pytanie (tresc "Are you really doing this quiz? I M P R E S S I V E! Do your parents want you to be a child prodigy?") (opcje "Yes!" "No, I'm happy just to play")))
)

(defrule q_how_old_6_12
    (odpowiedz_do_pytania (tresc "How old are you?") (odpowiedz "6-12"))
=>
    (assert (pytanie (tresc "Are you prepared to put in a lot of practice time?") (opcje "No I just want to get playing as quickly as possible" "Yes")))
)

(defrule q_how_old_13
    (odpowiedz_do_pytania (tresc "How old are you?") (odpowiedz "13+"))
=>
    (assert (pytanie (tresc "Do you have unlimited time, lots of money and a van?") (opcje "Yes I've also got a chauffeur" "Not really"))) 
)

(defrule q_childprodigy_yes  
    (odpowiedz_do_pytania (tresc "Are you really doing this quiz? I M P R E S S I V E! Do your parents want you to be a child prodigy?") (odpowiedz "Yes!"))
=>
    (assert (instrument "violin")) 
)

(defrule q_childprodigy_no
    (odpowiedz_do_pytania (tresc "Are you really doing this quiz? I M P R E S S I V E! Do your parents want you to be a child prodigy?") (odpowiedz "No, I'm happy just to play"))
=>
    (assert (pytanie (tresc "Are you prepared to put in a lot of practice time?") (opcje "No I just want to get playing as quickly as possible" "Yes")))
)

(defrule q_practicetime_no_i_just_want_to_get_playing_as_quickly_as_possible
    (odpowiedz_do_pytania (tresc "Are you prepared to put in a lot of practice time?") (odpowiedz "No I just want to get playing as quickly as possible"))
=>
    (assert (pytanie (tresc "Do you want to drive your family mad?") (opcje "Wouldn't I just" "I'm not a brat!")))
)

(defrule q_practicetime_yes
    (odpowiedz_do_pytania (tresc "Are you prepared to put in a lot of practice time?") (odpowiedz "Yes"))
=>
    (assert (instrument "piano"))
)

(defrule q_timemoney_yes
    (odpowiedz_do_pytania (tresc "Do you have unlimited time, lots of money and a van?") (odpowiedz "Yes I've also got a chauffeur"))      
=>
    (assert (instrument "harp"))
)

(defrule q_timemoney_no
    (odpowiedz_do_pytania (tresc "Do you have unlimited time, lots of money and a van?") (odpowiedz "Not really"))
=>
    (assert (pytanie (tresc "Do you consider yourself to have some musical ability?") (opcje "Not an IOTA" "I have some" "Yes, I'm amazing")))
)

(defrule q_familymad_yes
    (odpowiedz_do_pytania (tresc "Do you want to drive your family mad?") (odpowiedz "Wouldn't I just"))
=>
    (assert (instrument recorder))
)

(defrule q_familymad_no
    (odpowiedz_do_pytania (tresc "Do you want to drive your family mad?") (odpowiedz "I'm not a brat!"))
=>
    (assert (pytanie (tresc "Do you have a big house?") (opcje "I live in a church" "There's plenty of room" "It's more compact and bijou")))
)

(defrule q_musicalability_not_an_iota
    (odpowiedz_do_pytania (tresc "Do you consider yourself to have some musical ability?") (odpowiedz "Not an IOTA"))
=>
    (assert (instrument "comb and tissue paper"))
)

(defrule q_musicalability_i_have_some
    (odpowiedz_do_pytania (tresc "Do you consider yourself to have some musical ability?") (odpowiedz "I have some"))
=>
    (assert (pytanie (tresc "Fancy yourself as a composer?") (opcje "Yes roll over Beethoven" "Not particularly")))
)

(defrule q_musicalability_im_amazing
    (odpowiedz_do_pytania (tresc "Do you consider yourself to have some musical ability?") (odpowiedz "Yes, I'm amazing"))
=>
    (assert (pytanie (tresc "Do you have nerves and an upper lip of steel?") (opcje "Not quite" "That sounds just like me")))
)

(defrule q_steel_not_quite
    (odpowiedz_do_pytania (tresc "Do you have nerves and an upper lip of steel?") (odpowiedz "Not quite"))
=>
    (assert (instrument "piano"))
)

(defrule q_steel_yes
    (odpowiedz_do_pytania (tresc "Do you have nerves and an upper lip of steel?") (odpowiedz "That sounds just like me"))
=>
    (assert (instrument "french horn"))
)

(defrule q_bighouse_live_in_a_church
    (odpowiedz_do_pytania (tresc "Do you have a big house?") (odpowiedz "I live in a church"))
=>
    (assert (instrument "organ"))
)

(defrule q_bighouse_plenty_of_room
    (odpowiedz_do_pytania (tresc "Do you have a big house?") (odpowiedz "There's plenty of room"))     
=>
    (assert (pytanie (tresc "Do you want to play in an orchestra?") (opcje "Too many people, too much noise" "My life is like a symphony!" "Only if it's Baroque")))
)

(defrule q_bighouse_compact
    (odpowiedz_do_pytania (tresc "Do you have a big house?") (odpowiedz "It's more compact and bijou"))
=>
    (assert (pytanie (tresc "Do you hate your neighbours?") (opcje "With a passion" "No, they're quite nice")))
)

(defrule q_composer_yes
    (odpowiedz_do_pytania (tresc "Fancy yourself as a composer?") (odpowiedz "Yes roll over Beethoven"))
=>
    (assert (pytanie (tresc "Are you more Mozart or more McCartney?") (opcje "Mozart" "McCartney")))   
)

(defrule q_composer_no
    (odpowiedz_do_pytania (tresc "Fancy yourself as a composer?") (odpowiedz "Not particularly"))      
=>
    (assert (pytanie (tresc "Do you want to be centre of attention?") (opcje "Yes I'm gonna be a star" "Not really, I'm a team player")))  
)

(defrule q_orchestra_too_many_people_too_much_noise
    (odpowiedz_do_pytania (tresc "Do you want to play in an orchestra?") (odpowiedz "Too many people, too much noise"))
=>
    (assert (instrument "piano"))
)

(defrule q_orchestra_my_life_is_like_a_symphony
    (odpowiedz_do_pytania (tresc "Do you want to play in an orchestra?") (odpowiedz "My life is like a symphony!"))
=>
    (assert (pytanie (tresc "Do you enjoy lifting heavy weights?") (opcje "I'm often mistaken for Superman" "I'm not a wimp, but...")))    
)

(defrule q_orchestra_only_if_its_baroque
    (odpowiedz_do_pytania (tresc "Do you want to play in an orchestra?") (odpowiedz "Only if it's Baroque"))
=>
    (assert (pytanie (tresc "Dost thou wish to sit as stand?") (opcje "Sitteth" "Standeth")))
)

(defrule q_hate_neighbours_with_a_passion
    (odpowiedz_do_pytania (tresc "Do you hate your neighbours?") (odpowiedz "With a passion"))
=>
    (assert (pytanie (tresc "Do you have a good sense of rhythm & timing?") (opcje "I'm a human metronome" "It's OK I guess")))
)

(defrule q_hate_neighbours_no
    (odpowiedz_do_pytania (tresc "Do you hate your neighbours?") (odpowiedz "No, they're quite nice")) 
=>
    (assert (pytanie (tresc "Do you like folk music?") (opcje "I always wear flowers in my hair" "I'm not a hippy")))
)

(defrule q_mccartney_mozart
    (odpowiedz_do_pytania (tresc "Are you more Mozart or more McCartney?") (odpowiedz "Mozart"))       
=>
    (assert (instrument "piano"))
)

(defrule q_mccartney_mccartney      
    (odpowiedz_do_pytania (tresc "Are you more Mozart or more McCartney?") (odpowiedz "McCartney"))    
=>
    (assert (instrument "acoustic guitar"))
)

(defrule q_attention_yes_star
    (odpowiedz_do_pytania (tresc "Do you want to be centre of attention?") (odpowiedz "Yes I'm gonna be a star"))
=>
    (assert (instrument "piano"))
)

(defrule q_attention_no
    (odpowiedz_do_pytania (tresc "Do you want to be centre of attention?") (odpowiedz "Not really, I'm a team player"))
=>
    (assert (pytanie (tresc "Do you have a big house?") (opcje "I live in a church" "There's plenty of room" "It's more compact and bijou")))
)

(defrule q_weights_superman
    (odpowiedz_do_pytania (tresc "Do you enjoy lifting heavy weights?") (odpowiedz "I'm often mistaken for Superman"))
=>
    (assert (pytanie (tresc "Do you fancy a bit of jazz on the side?") (opcje "Jazz isn't music, It's noise" "Sure thing, cat!")))
)

(defrule q_weights_no
    (odpowiedz_do_pytania (tresc "Do you enjoy lifting heavy weights?") (odpowiedz "I'm not a wimp, but..."))
=>
    (assert (pytanie (tresc "Do you have an aversion to spit or condensation?") (opcje "Yuck, I prefer staying dry" "Music above hygiene")))
)

(defrule q_stand_sitteth
    (odpowiedz_do_pytania (tresc "Dost thou wish to sit as stand?") (odpowiedz "Sitteth"))
=>
    (assert (instrument "lute"))
)

(defrule q_stand_standeth
    (odpowiedz_do_pytania (tresc "Dost thou wish to sit as stand?") (odpowiedz "Standeth"))
=>
    (assert (instrument "harpsichord"))
)

(defrule q_rhyme_perfect
    (odpowiedz_do_pytania (tresc "Do you have a good sense of rhythm & timing?") (odpowiedz "I'm a human metronome"))
=>
    (assert (instrument "percussion"))
)

(defrule q_rhyme_ok_i_guess    
    (odpowiedz_do_pytania (tresc "Do you have a good sense of rhythm & timing?") (odpowiedz "It's OK I guess"))
=>
    (assert (instrument "trombone"))
)

(defrule q_folk_i_always_wear_flowers_in_my_hair
    (odpowiedz_do_pytania (tresc "Do you like folk music?") (odpowiedz "I always wear flowers in my hair"))
=>
    (assert (instrument "acoustic guitar"))
)

(defrule q_folk_im_not_a_hippy     
    (odpowiedz_do_pytania (tresc "Do you like folk music?") (odpowiedz "I'm not a hippy"))
=>
    (assert (instrument "digital piano"))
)

(defrule q_jazz_no
    (odpowiedz_do_pytania (tresc "Do you fancy a bit of jazz on the side?") (odpowiedz "Jazz isn't music, It's noise"))
=>
    (assert (instrument "tuba"))
)

(defrule q_jazz_yes
    (odpowiedz_do_pytania (tresc "Do you fancy a bit of jazz on the side?") (odpowiedz "Sure thing, cat!"))
=>
    (assert (instrument "double bass"))
)

(defrule q_condensation_yuck
    (odpowiedz_do_pytania (tresc "Do you have an aversion to spit or condensation?") (odpowiedz "Yuck, I prefer staying dry"))
=>
    (assert (pytanie (tresc "Do you mind being the butt of people's jokes?") (opcje "GOODNESS NO. I'm terribly sensitive" "I love a good laugh")))
)

(defrule q_condensation_music_above_hygiene
    (odpowiedz_do_pytania (tresc "Do you have an aversion to spit or condensation?") (odpowiedz "Music above hygiene"))
=>
    (assert (pytanie (tresc "Do you want a challenge?") (opcje "Life's too short" "I like a challenge" "Bring it on, give me a real challenge!")))
)

(defrule q_jokes_terribly_sensitive
    (odpowiedz_do_pytania (tresc "Do you mind being the butt of people's jokes?") (odpowiedz "GOODNESS NO. I'm terribly sensitive"))       
=>
    (assert (instrument "cello"))
)

(defrule q_jokes_love_a_good_laugh
    (odpowiedz_do_pytania (tresc "Do you mind being the butt of people's jokes?") (odpowiedz "I love a good laugh"))
=>
    (assert (instrument "viola"))
)

(defrule q_challenge_no
    (odpowiedz_do_pytania (tresc "Do you want a challenge?") (odpowiedz "Life's too short"))
=>
    (assert (pytanie (tresc "Do you mind fiddling about with reeds?") (opcje "That sounds like way too much hassle" "I love frustrating manual tasks")))
)

(defrule q_challenge_like_a_challenge
    (odpowiedz_do_pytania (tresc "Do you want a challenge?") (odpowiedz "I like a challenge"))
=>
    (assert (instrument "bassoon"))
)

(defrule q_challenge_love
    (odpowiedz_do_pytania (tresc "Do you want a challenge?") (odpowiedz "Bring it on, give me a real challenge!"))
=>
    (assert (instrument "oboe"))
)

(defrule q_reeds_that_sounds_like_way_too_much_hassle
    (odpowiedz_do_pytania (tresc "Do you mind fiddling about with reeds?") (odpowiedz "That sounds like way too much hassle"))
=>
    (assert (pytanie (tresc "Loud and bold or soft and elegant?") (opcje "LOUDER!!!" "Elegant, please")))
)

(defrule q_reeds_i_love_frustrating_manual_tasks
    (odpowiedz_do_pytania (tresc "Do you mind fiddling about with reeds?") (odpowiedz "I love frustrating manual tasks"))
=>
    (assert (pytanie (tresc "Do you want to moonlight in an 80s cover band?") (opcje "If I get my own solo" "Definitely NOT")))
)

(defrule q_elegant_louder        
    (odpowiedz_do_pytania (tresc "Loud and bold or soft and elegant?") (odpowiedz "LOUDER!!!"))        
=>
    (assert (instrument "trumpet"))
)

(defrule q_elegant_elegant  
    (odpowiedz_do_pytania (tresc "Loud and bold or soft and elegant?") (odpowiedz "Elegant, please"))  
=>
    (assert (instrument "flute"))
)

(defrule q_cover_my_own_solo
    (odpowiedz_do_pytania (tresc "Do you want to moonlight in an 80s cover band?") (odpowiedz "If I get my own solo"))
=>
    (assert (instrument "saxophone"))
)

(defrule q_cover_definitely_not     
    (odpowiedz_do_pytania (tresc "Do you want to moonlight in an 80s cover band?") (odpowiedz "Definitely NOT"))
=>
    (assert (instrument "clarinet"))
)
