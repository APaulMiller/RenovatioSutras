////
////  SutraTextVC.swift
////  RenovatioS
////
////  Created by Paul Miller on 6/7/17.
////  Copyright © 2017 TPOYP. All rights reserved.
////
//
//import UIKit
//
//
//
//var FrontPage:String =  "Acknowledgements <style type=\"text/css\">#blue{font-weight: Bold}</style><span id=\"blue\">with Bold Text</span>"
//var Awake:String =  "Awake Text"
//var Behaviour:String =  "Behaviour Text"
//var Complacency:String =  "Complacency Text"
//var GivingYourHeart:String =  "GivingYourHeart Text"
//var GrowingYour:String =  "GrowingYour Text"
//var HigherThan:String =  "Higher Than Forgiveness"
//var InnerPeace:String =  "InnerPeace Text"
//var Liberation:String =  "Liberation Text"
//var LifesTrials:String =  "LifesTrials Text"
//var Limiting:String =  "Limiting Text"
//var Relaxation:String =  "Relaxation Text"
//var Resistance:String =  "Resistance Text"
//var SacredGround:String =  "SacredGround Text"
//var Universe:String =  "The Universe Text"
//var BecomingaMirror:String =  "<style type=\"text/css\"> #b{font-weight: Bold} #i{font-style: Italic} #u{text-decoration: underline} </style>Becoming a Mirror Text VVB<b>with Bold Text,</b><i> italic Text,</i> and <u>Underline </u> "
//var BelievinginOurselves:String =  "Believing in Ourselves Text"
//var Change:String =  "Change Text"
//var ComfortZone:String =  "Comfort Zone Text"
//var CreatinginourBody:String =  "Creating in our Body Text"
//var DeadandBuried:String =  "Dead and Buried Text"
//var Earth:String =  "Earth Text"
//var Energy:String =  "Energy Text"
//var ExperienceandEssence:String =  "Experience and Essence Text"
//var Faith:String =  "Faith Text"
//var FeedingonourPain:String =  "Feeding on our Pain Text"
//var FindingaCure:String =  "Finding a Cure Text"
//var FindingSelfWorth:String =  "Elaboration \n\nSometimes we have to find self-worth outside ourselves in order to know what it’ll feel like inside, \n\n There are times in our lives when we might go through a period of very low self-worth. It could be in childhood or when we start to date (perhaps unsuccessfully), or even later in life when we get laid off and find it hard to get another job; perhaps our marriage fails and we feel rejected. In these times, when our self-worth is so low and we look inside, there is no hope to be found. There is nothing to make us want to get up each day. How do we dig ourselves out of this deep, dark, bone-chillingly cold, lonely hole that we find ourselves in? How do we create a kernel of self-worth with which to start rebuilding ourselves? A simple start might be to use something outside of ourselves to create a kernel. \nWhen someone compliments us, either for something we did or how we look, we feel good about ourselves. It gives us a nice feeling inside and we feel special. Sometimes we might not even have to hear a compliment. If we are wearing some new clothes and we notice that people are glancing at us because of how good they think we look, that can also create a nice feeling inside. Or we are with others doing something as a group and they compliment us on our contribution. \n\nThere is a difference between feeling good and having self-worth. Feeling good is a nice emotion to have and we can enjoy it for however long it lasts, but it does not fundamentally affect who and how we are. A lack of self-worth will seep into every one of our perceptions and as a consequence every aspect of our life. So even if something happens that is nice for us, then it will either be ignored or its full joy will be muted. \n\nbut this is no more of a permanent solution than taking a painkiller because you have a bad tooth. \nSooner or later you have to get the tooth fixed. \n\nThis feeling we get from outside is the feeling that we are looking to have inside us all the time. We can use it to remind ourselves what we should be feeling all the time inside. These days with so many social media sites many people derive a sense of being valued from external sources—by how many “likes” they get for a self-portrait photograph or how many “followers” they have. However, we must remember that we need to create the feel-good factor internally. The dependency on external input to create self-worth is only a temporary stopgap, a reminder to help us start creating our inner kernel. \n\nThe emptiness that we feel inside due to lack of self-worth can never be permanently filled if we depend on external sources; eventually we have to fill the void ourselves from within. One way to do this is to do something that will make you feel good that does not depend on someone else’s positive feedback. For example: cleaning up that room that you just never get around to doing, or tracking your fitness routine and noticing your progress, or cooking yourself a healthy meal from scratch rather than heating something up in the microwave. The key is to find something that you recognize as something good for you that does not depend on anyone else knowing about it."
//var Fire:String =  "Fire Text"
//var Forgiveness:String =  "Forgiveness Text"
//var GivingyourHeart:String =  "Giving your Heart Text"
//var GreatAwareness:String =  "Great Awareness Text"
//var GreatestSacrifice:String =  "Greatest Sacrifice Text"
//var GrowingyourInsights:String =  "Growing your Insights Text"
//var GrowingyourLove:String =  "Growing your Love Text"
//var HeartofGod:String =  "Heart of God Text"
//var HigherThanForgiveness:String =  "Higher Than Forgiveness Text"
//var HowYouareNow:String =  "How You are Now Text"
//var Iceberg:String =  "Iceberg Text"
//var InsideChange:String =  "Inside Change Text"
//var Inside:String =  "Inside Text"
//var KeepTrying:String =  "Keep Trying Text"
//var LimitingYourself:String =  "So many times and in so many ways we try to improve who and how we are with ourselves and the world around us. Initially we try the easiest way then gradually more and more 'challenging' ways all up to our internal comfort zone limit and then perhaps only with limited or no sucess. In the end we might just accept or learn to live with who and how we are. Profound growth only happens when we go to the edge of our internal confront zone and take a step outside it."
//var LivingaSpiritualLife:String =  "Living a Spiritual Life Text"
//var Meditation:String =  "Meditation Text"
//var MoonandStars:String =  "Moon and Stars Text"
//var MovingclosertoGod:String =  "Moving closer to God Text"
//var NailandBlame:String =  "Nail and Blame Text"
//var Offence:String =  "Offence Text"
//var OwningyourInsights:String =  "Owning your Insights Text"
//var ParasiteofJudgement:String =  "Parasite of Judgement Text"
//var Reality:String =  "Reality Text"
//var SteppingoutinFaith:String =  "Stepping out in Faith Text"
//var TakingResponsibility:String =  "Taking Responsibility Text"
//var TheUniverse:String =  "The Universe Text"
//var Water:String =  "Water Text"
//var WhoYouareBeing:String =  "Who You are Being Text"
//var Wind:String =  "Wind Text"
//var YourConsciousness:String =  "Your Consciousness Text"
//
//
//var RSarray = [FrontPage, Awake, BecomingaMirror, Behaviour, BelievinginOurselves, Change, ComfortZone, Complacency, CreatinginourBody, DeadandBuried, Earth, Energy, ExperienceandEssence, Faith, FeedingonourPain, FindingaCure, FindingSelfWorth, Fire, Forgiveness, GivingyourHeart, GreatAwareness, GreatestSacrifice, GrowingyourInsights, GrowingyourLove, HeartofGod,  HigherThanForgiveness ,  HowYouareNow ,  Iceberg , InnerPeace ,  InsideChange ,  Inside ,  KeepTrying ,  Liberation ,  LifesTrials ,  LimitingYourself ,  LivingaSpiritualLife ,  Meditation ,  MoonandStars ,  MovingclosertoGod ,  NailandBlame ,  Offence ,  OwningyourInsights ,  ParasiteofJudgement ,  Reality ,  Relaxation ,  Resistance ,  SacredGround ,  SteppingoutinFaith ,  TakingResponsibility , TheUniverse ,  Water ,  WhoYouareBeing , Wind , YourConsciousness ]
//
