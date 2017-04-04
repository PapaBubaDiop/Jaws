//
//  Menu.swift
//  Zabivaka
//
//  Created by Vadim Bashurov on 11/6/16.
//  Copyright © 2016 vadim. All rights reserved.
//

import Foundation

struct City {
    var name:String = ""
    var x:CGFloat = 0
    var y:CGFloat = 0
    var s:Int = 0
}

struct Dummy {
    var x:CGFloat = 0
    var y:CGFloat = 0
    var s:Int = 0
}



class Menu {

var cities:[City] = [

    City(name:"NY",x:40.7528,y:-73.9725,s:0),
    City(name:"Glenn",x:61.1427,y:-97.9218,s:0),
    City(name:"Anchorage",x:59.2181,y:-119.9003,s:0),
    City(name:"Platinum",x:56.9625,y:-131.7466,s:0),
    City(name:"Ruby",x:62.7394,y:-125.4869,s:0),
    City(name:"Juneau",x:56.3019,y:-104.4197,s:0),
    City(name:"Pittsburgh",x:40.4495,y:-79.9880,s:0),
    City(name:"Oklahoma",x:35.5798,y:-97.5731,s:0),
    City(name:"SF",x:37.7353,y:-122.3732,s:0),
    City(name:"Chicago",x:41.9288,y:-87.6315,s:0),
    City(name:"LA",x:34.0396,y:-118.2661,s:0),
    City(name:"Philadelphia",x:38.9524,y:-75.1653,s:0),
    City(name:"Boston",x:42.3496,y:-71.0746,s:0),
    City(name:"Dallas",x:32.7825,y:-96.8207,s:0),
    City(name:"New Orleans",x:31.0309,y:-90.0680,s:0),
 
    City(name:"Miami",x:25.7615,y:-80.2939,s:0),
    City(name:"Detroit",x:43.3679,y:-83.1386,s:0),
    City(name:"Seattle",x:47.6026,y:-122.3284,s:0),
    City(name:"Kansas",x:39.1068,y:-94.5660,s:0),
    City(name:"Colorado",x:38.8339,y:-104.8214,s:0),
    City(name:"Portland",x:45.5171,y:-122.6802,s:0),
    City(name:"Houston",x:29.7629,y:-95.2565,s:0),
    City(name:"San Diego",x:32.9014,y:-117.2079,s:0),
    City(name:"Salt",x:40.7608,y:-111.8911,s:0),
    
 
    City(name:"Las Vegas",x:36.1100,y:-115.2118,s:0),
    City(name:"Austin",x:30.3660,y:-103.6437,s:0),
    City(name:"Washington",x:37.8951,y:-77.0364,s:0),
    City(name:"Orlando",x:28.5883,y:-81.2439,s:0),
    City(name:"Charlotte",x:35.1232,y:-80.9343,s:0),
    
    
    
    
    
    
    City(name:"Paris",x:48.8667,y:2.3333,s:1),
    City(name:"Lyon",x:45.7485, y:4.8467,s:1),
   City(name:"Montpellier",x:43.6109,y:3.8772,s:1),
   City(name:"Toulouse",x:43.5995,y:1.4332,s:1),
   City(name:"Lille",x:50.6330,y:3.0586,s:1),
   City(name:"Bordeaux",x:44.8404,y:-0.5805,s:1),
   City(name:"Amiens",x:49.9000,y:2.3000,s:1),
   City(name:"Strasbourg",x:48.6004,y:7.7874,s:1),
       City(name:"Orleans",x:47.9029,y:1.9039,s:1),
       City(name:"Metz",x:49.1155,y:6.1759,s:1),
       City(name:"Nancy",x:48.6921,y:6.1878,s:1),
       City(name:"Nice",x:43.7136,y:7.2595,s:1),
       City(name:"Rouen",x:49.4333,y:1.0833,s:1),
       City(name:"Rennes",x:48.1120,y:-1.6743,s:1),
       City(name:"Marseille",x:43.2854,y:5.3761,s:1),
       City(name:"Grenoble",x:45.1715,y:5.7224,s:1),
       City(name:"Brest",x:48.3908,y:-4.4862,s:1),
       City(name:"Nantes",x:47.2165,y:-1.5524,s:1),
       City(name:"Dijon",x:47.3167,y:5.0167,s:1),
       City(name:"Bajamont",x:44.2656,y:0.7073,s:1),
       City(name:"Ceignac",x:44.2730,y:2.5229,s:1),
       City(name:"Ornon",x:45.8564,y:3.3857,s:1),
       City(name:"Labeaume",x:44.4492,y:4.3073,s:1),
       City(name:"Salies",x:43.4702,y:-0.9254,s:1),
        City(name:"Flers",x:49.0311,y:-0.5761,s:1),
        City(name:"Souvign",x:47.8268,y:-0.3885,s:1),
       City(name:"Niort",x:46.3231,y:-0.4588,s:1),
        City(name:"Perret",x:45.8167,y:5.9167,s:1),
        City(name:"Cormelles",x:45.6535,y:0.3335,s:1),
        
        
        
        
        City(name:"London",x:51.5142,y:-0.0931,s:2),
        City(name:"Plymouth",x:50.3964,y:-4.1386,s:2),
        City(name:"Inverness",x:57.4667,y:-4.2333,s:2),
        City(name:"Colchester",x:51.8833,y:0.9000,s:2),
        City(name:"Manchester",x:53.5000,y:-2.2167,s:2),
        City(name:"Liverpool",x:53.4087,y:-2.9701,s:2),
        City(name:"Kidlington",x:51.8167,y:-1.2833,s:2),
        City(name:"Sheffield",x:53.3667,y:-1.5000,s:2),
        City(name:"Derby",x:52.9333,y:-1.5000,s:2),
        City(name:"Bristol",x:51.4500,y:-2.5833,s:2),
        
        City(name:"M-boro",x:55.1728,y:-1.1628,s:2),
        City(name:"Newcastle",x:54.9881,y:-1.6194,s:2),
        City(name:"Cardiff",x:51.5000,y:-3.2000,s:2),
        City(name:"Reading",x:51.4333,y:-1.0000,s:2),
        City(name:"Ashford",x:51.1333,y:0.8833,s:2),
   
        City(name:"Stirling",x:56.1167,y:-3.9500,s:2),
        City(name:"Glasgow",x:55.8333,y:-4.2500,s:2),
        City(name:"Cambridge",x:52.2000,y:0.1167,s:2),
        City(name:"Shrewsbury",x:52.7167,y:-2.7333,s:2),
        City(name:"Aberdeen",x:57.1333,y:-2.1000,s:2),
        
        City(name:"Sywell",x:52.2833,y:-0.7833,s:2),
        City(name:"Southampton",x:50.9000,y:-1.4000,s:2),
        City(name:"Dundee",x:56.5000,y:-2.9667,s:2),
        City(name:"Leeds",x:53.8000,y:-1.5833,s:2),
        City(name:"Birmingham",x:52.4667,y:-1.9167,s:2),
        City(name:"Wear",x:50.7000,y:-3.4833,s:2),
        City(name:"Belfast",x:54.5833,y:-5.9333,s:2),
        City(name:"Dunfermline",x:56.0833,y:-3.4667,s:2),
        City(name:"Grange",x:54.1833,y:-2.9167,s:2),
        
        City(name:"Berlin",x:52.5167,y:13.4000,s:3),
        City(name:"Munich",x:48.1500,y:11.5833,s:3),
        City(name:"Hamburg",x:53.5500,y:10.0000,s:3),
        City(name:"Frankfurt",x:50.1167,y:8.6833,s:3),
        City(name:"Karlsruhe",x:49.0047,y:8.3858,s:3),
        City(name:"Cologne",x:50.9333,y:6.9500,s:3),
        City(name:"Stuttgart",x:48.7667,y:9.1833,s:3),
        City(name:"Dsseldorf",x:51.2167,y:6.7667,s:3),
        City(name:"Dortmund",x:51.5167,y:7.4500,s:3),
        City(name:"Hessen",x:52.0167,y:10.7833,s:3),
        City(name:"Bochum",x:51.4833,y:7.2167,s:3),
        City(name:"Bremen",x:53.0833,y:8.8000,s:3),
        City(name:"Aachen",x:50.7708,y:6.1053,s:3),
        City(name:"Rostock",x:54.0833,y:12.1333,s:3),
        City(name:"Kiel",x:54.3333,y:10.1333,s:3),
     
        City(name:"Papstdorf",x:50.9000,y:14.1333,s:3),
        City(name:"Rosendahl",x:54.4833,y:9.1000,s:3),
        City(name:"Dahlem",x:49.9167,y:6.6000,s:3),
        City(name:"Oberhof",x:53.9500,y:11.2333,s:3),
        City(name:"Erfurt",x:50.9833,y:11.0333,s:3),
        
        City(name:"Mainz",x:50.0000,y:8.2711,s:3),
        City(name:"Siegen",x:50.8667,y:8.0333,s:3),
        City(name:"Leipzig",x:51.3000,y:12.3333,s:3),
        City(name:"Gartow",x:52.8833,y:12.5167,s:3),
        City(name:"Maubach",x:48.9167,y:9.4333,s:3),
        City(name:"Kassel",x:51.3167,y:9.5000,s:3),
        City(name:"Hohen",x:51.5667,y:12.0667,s:3),
        City(name:"Berzdorf",x:51.0667,y:14.9000,s:3),
        City(name:"Braunschweig",x:52.2667,y:10.5333,s:3),
        
        
        City(name:"Rome",x:41.9000,y:12.4833,s:4),
        City(name:"Ancona",x:43.6333,y:13.5000,s:4),
        City(name:"Ascoli",x:42.8500,y:13.5667,s:4),
        City(name:"Bari",x:41.1333,y:16.8500,s:4),
        City(name:"Bologna",x:44.4833,y:11.3333,s:4),
        City(name:"Brescia",x:45.5500,y:10.2500,s:4),
        City(name:"Catania",x:37.5000,y:15.1000,s:4),
        City(name:"Cesena",x:44.1433,y:12.2497,s:4),
        City(name:"Cagliari",x:39.2167,y:9.1167,s:4),
        City(name:"Florence",x:43.7667,y:11.2500,s:4),
        
        City(name:"Foggia",x:41.4500,y:15.5667,s:4),
        City(name:"Genova",x:44.4167,y:8.9500,s:4),
        City(name:"Lecce",x:40.3833,y:18.1833,s:4),
        City(name:"Milan",x:45.4667,y:9.2000,s:4),
        City(name:"Messina",x:38.1939,y:15.5526,s:4),
        City(name:"Crotone",x:39.0833,y:17.1333,s:4),
        City(name:"Napoli",x:40.8333,y:14.2500,s:4),
         City(name:"Perugia",x:43.1333,y:12.3667,s:4),
        City(name:"Palermo",x:38.1167,y:13.3667,s:4),
        City(name:"Parma",x:44.8000,y:10.3333,s:4),
        
        City(name:"Piacenza",x:45.0601,y:9.4378,s:4),
        City(name:"Pisa",x:43.7167,y:10.3833,s:4),
        City(name:"Pescara",x:42.4667,y:14.2167,s:4),
        City(name:"Salerno",x:40.6833,y:14.7833,s:4),
        City(name:"Trento",x:46.1670,y:11.3008,s:4),
        City(name:"Trieste",x:45.6486,y:13.7800,s:4),
        City(name:"Torino",x:45.0500,y:7.6667,s:4),
        City(name:"Verona",x:45.4500,y:11.0000,s:4),
        City(name:"Venezia",x:45.4386,y:12.3267,s:4),
        
        
        
        City(name:"Madrid",x:40.4086,y:-3.6922,s:5),
        City(name:"Alun",x:43.0135,y:-8.8300,s:5),
        City(name:"Alea",x:43.4333,y:-5.1500,s:5),
        City(name:"Alcocer",x:40.4697,y:-2.6094,s:5),
        
        City(name:"Albacete",x:38.9958,y:-1.8578,s:5),
        City(name:"Barcelona",x:41.3984,y:2.1741,s:5),
        City(name:"Marbella",x:36.5105,y:-4.8857,s:5),
        City(name:"Osma",x:42.8908,y:-3.0640,s:5),
        City(name:"Zaragoza",x:41.6453,y:-0.8849,s:5),
        City(name:"San Salvador",x:43.3926,y:-3.8060,s:5),
        City(name:"Sevilla",x:37.3824,y:-5.9761,s:5),
        City(name:"Linares",x:38.0952,y:-3.6360,s:5),
        
        City(name:"Valdeorras",x:42.4189,y:-6.9818,s:5),
        City(name:"Valladolid",x:41.6552,y:-4.7237,s:5),
        City(name:"Valencia",x:39.4667,y:-0.3667,s:5),
        City(name:"Malaga",x:36.7267,y:-4.4348,s:5),
        City(name:"Murcia",x:37.9870,y:-1.1300,s:5),
        City(name:"Vigo",x:42.2328,y:-8.7226,s:5),
        City(name:"La Coruna",x:35.0333,y:-11.6667,s:5),
        
        City(name:"Salamanca",x:40.9681,y:-5.6620,s:5),
        City(name:"Gijun",x:43.5357,y:-5.6615,s:5),
 
        City(name:"Merida",x:38.9161,y:-6.3437,s:5),
        City(name:"Cordoba",x:37.7000,y:-4.9500,s:5),
        City(name:"Toledo",x:39.8581,y:-4.0226,s:5),
        City(name:"Lleida",x:41.6167,y:1.3500,s:5),
        City(name:"Pamplona",x:43.9141,y:-1.6412,s:5),
        
        City(name:"Beograd",x:44.8186,y:20.4681,s:6),
        City(name:"Novi Sad",x:45.2517,y:19.8369,s:6),
        City(name:"Kragujevac",x:44.0167,y:20.9167,s:6),
        City(name:"Kosovo",x:42.6394,y:21.0961,s:6),
        City(name:"Subotica",x:46.1000,y:19.6667,s:6),
        City(name:"Nis",x:43.0992,y:21.2019,s:6),
        City(name:"Uzice",x:43.8558,y:19.8411,s:6),
        City(name:"Sarajevo",x:43.8500,y:18.3833,s:6),
        City(name:"Banja Luka",x:44.7784,y:17.1939,s:6),
        City(name:"Dubrovnik",x:42.6506,y:18.0914,s:6),
        
        City(name:"Zagreb",x:45.8000,y:16.0000,s:6),
        City(name:"Split",x:43.5139,y:16.4558,s:6),
        City(name:"Rijeka",x:45.3431,y:14.4092,s:6),
        City(name:"Ljubljana",x:46.0553,y:14.5144,s:6),
        City(name:"Maribor",x:46.5547,y:15.6467,s:6),
        City(name:"Skopje",x:41.9965,y:21.4314,s:6),
        City(name:"Podgorica",x:42.4411,y:19.2636,s:6),
        City(name:"Zadar",x:44.1197,y:15.2422,s:6),
        City(name:"Osijek",x:45.5511,y:18.6939,s:6),
        City(name:"Gorizia",x:45.9450,y:13.5978,s:6),
        
        City(name:"Bitola",x:41.0314,y:21.3347,s:6),
        City(name:"Vranje",x:42.5514,y:21.9003,s:6),
        
        ]

    
    var dummies:[Dummy] = [
        
        Dummy(x:30,y:120,s:0),
        Dummy(x:30,y:170,s:0),
        Dummy(x:45,y:230,s:0),
        Dummy(x:20,y:300,s:0),
        Dummy(x:40,y:380,s:0),
        Dummy(x:305,y:120,s:0),
        Dummy(x:305,y:240,s:0),
        Dummy(x:310,y:300,s:0),
        Dummy(x:310,y:370,s:0),
        Dummy(x:290,y:420,s:0),
        Dummy(x:80,y:60,s:0),
        Dummy(x:140,y:50,s:0),
        Dummy(x:200,y:50,s:0),
        Dummy(x:260,y:60,s:0),
        Dummy(x:80,y:470,s:0),
        Dummy(x:140,y:470,s:0),
        Dummy(x:200,y:450,s:0),
        Dummy(x:310,y:455,s:0),
        Dummy(x:260,y:500,s:0),
  
        Dummy(x:80,y:240,s:0),
        Dummy(x:120,y:255,s:0),
        Dummy(x:160,y:250,s:0),
        Dummy(x:210,y:245,s:0),
        
        
        
        Dummy(x:20,y:120,s:1),
        Dummy(x:20,y:240,s:1),
        Dummy(x:20,y:360,s:1),
        Dummy(x:20,y:370,s:1),
        Dummy(x:305,y:120,s:1),
        Dummy(x:305,y:240,s:1),
        Dummy(x:305,y:360,s:1),
        Dummy(x:305,y:370,s:1),
        Dummy(x:80,y:60,s:1),
        Dummy(x:140,y:50,s:1),
        Dummy(x:200,y:50,s:1),
        Dummy(x:260,y:60,s:1),
        Dummy(x:80,y:470,s:1),
        Dummy(x:140,y:470,s:1),
        Dummy(x:200,y:450,s:1),
        Dummy(x:260,y:460,s:1),
 
        
        Dummy(x:40,y:120,s:2),
        Dummy(x:50,y:180,s:2),
        Dummy(x:70,y:240,s:2),
  
        Dummy(x:105,y:265,s:2),
        Dummy(x:125,y:288,s:2),
        
        
        Dummy(x:80,y:300,s:2),
        Dummy(x:70,y:360,s:2),
        Dummy(x:50,y:400,s:2),
        Dummy(x:250,y:120,s:2),
        Dummy(x:240,y:240,s:2),
        Dummy(x:260,y:360,s:2),
        Dummy(x:310,y:360,s:2),
        Dummy(x:80,y:60,s:2),
        Dummy(x:140,y:50,s:2),
        Dummy(x:200,y:50,s:2),
        Dummy(x:260,y:60,s:2),
        Dummy(x:80,y:470,s:2),
        Dummy(x:140,y:470,s:2),
        Dummy(x:200,y:450,s:2),
        Dummy(x:260,y:460,s:2),
        Dummy(x:315,y:415,s:2),
 
        
        Dummy(x:20,y:120,s:3),
        Dummy(x:20,y:240,s:3),
        Dummy(x:20,y:360,s:3),
        Dummy(x:20,y:370,s:3),
        Dummy(x:305,y:120,s:3),
        Dummy(x:305,y:240,s:3),
        Dummy(x:305,y:360,s:3),
        Dummy(x:305,y:370,s:3),
        Dummy(x:80,y:60,s:3),
        Dummy(x:140,y:50,s:3),
        Dummy(x:200,y:50,s:3),
        Dummy(x:260,y:60,s:3),
        Dummy(x:80,y:470,s:3),
        Dummy(x:140,y:470,s:3),
        Dummy(x:200,y:450,s:3),
        Dummy(x:260,y:460,s:3),
        
        
        Dummy(x:30,y:120,s:4),
        Dummy(x:125,y:370,s:4),
    
        Dummy(x:170,y:350,s:4),
 
        Dummy(x:200,y:410,s:4),
        Dummy(x:205,y:420,s:4),
        
        
        Dummy(x:15,y:325,s:4),
        
        Dummy(x:100,y:240,s:4),
        Dummy(x:90,y:280,s:4),
        Dummy(x:110,y:320,s:4),
        Dummy(x:50,y:400,s:4),
        Dummy(x:200,y:120,s:4),
        Dummy(x:240,y:240,s:4),
        Dummy(x:190,y:200,s:4),
        Dummy(x:260,y:300,s:4),
        Dummy(x:270,y:350,s:4),
        Dummy(x:310,y:335,s:4),
        Dummy(x:290,y:375,s:4),
        Dummy(x:80,y:60,s:4),
        Dummy(x:140,y:50,s:4),
        Dummy(x:200,y:50,s:4),
        Dummy(x:260,y:60,s:4),
        Dummy(x:80,y:470,s:4),
        Dummy(x:140,y:470,s:4),
        Dummy(x:200,y:450,s:4),
        Dummy(x:260,y:420,s:4),
        Dummy(x:236,y:450,s:4),
        
        Dummy(x:20,y:120,s:5),
        Dummy(x:70,y:200,s:5),
        Dummy(x:75,y:230,s:5),
        Dummy(x:75,y:260,s:5),
        Dummy(x:75,y:300,s:5),
        Dummy(x:60,y:360,s:5),
        Dummy(x:10,y:440,s:5),
        Dummy(x:305,y:120,s:5),
        Dummy(x:305,y:240,s:5),
        Dummy(x:305,y:360,s:5),
        Dummy(x:305,y:370,s:5),
        Dummy(x:80,y:60,s:5),
        Dummy(x:140,y:50,s:5),
        Dummy(x:200,y:50,s:5),
        Dummy(x:260,y:60,s:5),
        Dummy(x:30,y:470,s:5),
        Dummy(x:100,y:430,s:5),
        Dummy(x:200,y:450,s:5),
        Dummy(x:260,y:460,s:5),
 
        
        
        
        Dummy(x:20,y:120,s:6),
        Dummy(x:20,y:240,s:6),
        Dummy(x:20,y:360,s:6),
        Dummy(x:20,y:370,s:6),
        Dummy(x:305,y:120,s:6),
        Dummy(x:305,y:240,s:6),
        Dummy(x:305,y:360,s:6),
        Dummy(x:305,y:370,s:6),
        Dummy(x:80,y:60,s:6),
        Dummy(x:140,y:50,s:6),
        Dummy(x:200,y:50,s:6),
        Dummy(x:260,y:60,s:6),
        Dummy(x:80,y:470,s:6),
        Dummy(x:140,y:470,s:6),
        Dummy(x:200,y:450,s:6),
        Dummy(x:260,y:460,s:6),
        
        
      ]
    
    
  
    var menuXpos = [Int]()
    var menuCount = [Int]()
    
    var hulls = [Convex]()
    
    var pts = [PointBall]()
    var hull = [MarkedPoint]()
    
    var xmin:CGFloat = 10
    var xmax:CGFloat = 320 - 10
    var ymin:CGFloat = 10
    var ymax:CGFloat = 560
    
    var numPts = 50
    var level = 1
    var idxLevel = 0
    var cntLevel = 0
    
    var holdrand  = 0
    
    func microsoft_rnd()->Int {
        var k = Int.multiplyWithOverflow(holdrand, 214013)
        k = Int.addWithOverflow(k.0, 2531011)
        holdrand =  k.0
        return Int((holdrand >> 16)  & 0x7FFF)
    }
    
    func microsoft_rand(_ number:Int)->Int {
        return microsoft_rnd() % number
    }
    
    
    
    
    func initBoard(_ lvl:Int, pzlId: Int, iPad:Int, iPhone:Int) {
        
        holdrand = pzlId
        
        if iPad == 0 {
            if iPhone == 0 {
                ymax = 470
            }
        } else {
            xmin = 10
            xmax = 768 - 10
            ymin = 10
            ymax = 1015
        }
        
  //      evalLevels()
        
        
        level = lvl
  
        var cnt = 0
        for c in cities {
            if c.s == level {
                cnt = cnt + 1
            }
        }
        
            for c in dummies {
                if c.s == level {
                    cnt = cnt + 1
                }
            }
        
        numPts = cnt + 4
        
        
        pts.removeAll()
 
        let temp = [Int]()
        
        
        for _ in 1...numPts {
            pts.append(PointBall(x:0,y:0,xc:0,yc:0,color:0,live:0, nrb:temp))
        }
        
        newPlay(level:level, iPad:iPad)
    }
    
    
    func newPlay(level:Int, iPad:Int) {
        let dr:CGFloat = 15.0
        
        for i in 0..<4 {
            pts[i].color = 0
            pts[i].live = 0
            switch i {
            case 0:
                pts[i].x = xmin - dr
                pts[i].y = ymin - dr
            case 1:
                pts[i].x = xmax + dr
                pts[i].y = ymin - dr
            case 2:
                pts[i].x = xmax + dr
                pts[i].y = ymax + dr
            case 3:
                pts[i].x = xmin - dr
                pts[i].y = ymax + dr
            default:
                pts[i].color = 0
            }
        }
        
 
        
        var x0 = cities[0].x
        var x1 = cities[0].x
        var y0 = cities[0].y
        var y1 = cities[0].y
        
        var cnt = 0
        var idx = 0
        
        idxLevel = -1
        
        for c in cities {
            if c.s == level {
                if idxLevel<0 {
                    idxLevel = idx
                }
                x0 = c.x
                x1 = c.x
                y0 = c.y
                y1 = c.y
                cnt = cnt + 1
            }
            idx = idx + 1
        }
        
        
        cntLevel = cnt
        
        for c in cities {
            if c.s == level {
                if c.x<x0 {
                    x0 = c.x
                }
                if c.y<y0 {
                    y0 = c.y
                }
                if c.x>x1 {
                    x1 = c.x
                }
                if c.y>y1 {
                    y1 = c.y
                }
            }
        }
        
        var i = 4
 
        
        let yh:CGFloat = iPad == 0 ? 300 : 550
        let yd:CGFloat = iPad == 0 ? 440 : 800
        let yw:CGFloat = iPad == 0 ? 260 : 520
        
        
        let ddy:CGFloat = yh/(x1-x0)
        var ddx:CGFloat = 0.75*(y1-y0)*ddy
        
        if ddx>yw {
            ddx = yw
        }
        
        let dd0:CGFloat = iPad == 0 ? (320 - ddx)/2 : (768 - ddx)/2
        
        print("x1-x0= \(x1-x0)    y1-y0= \(y1-y0)")
        
        for j in cities.indices {
            if cities[j].s == level {
                pts[i].live = 1
                pts[i].color = 1
                var y = (cities[j].x - x0)/(x1-x0)
                var x = (cities[j].y - y0)/(y1-y0)
                x = dd0 + ddx*x
                y = yd - yh*y
                pts[i].x = x
                pts[i].y = y
                i = i + 1
            }
        }
        
        
        if iPad == 0 {
            for d in dummies {
                if d.s == level {
                    pts[i].live = 1
                    pts[i].color = 0
                    pts[i].x = d.x
                    pts[i].y = d.y
                    i = i + 1
                }
            }
        } else {
            for d in dummies {
                if d.s == level {
                    pts[i].live = 1
                    pts[i].color = 0
                    pts[i].x = 20 + d.x*2.3
                    pts[i].y = -40 + d.y*2
                    i = i + 1
                }
            }
        }
        
        hulls = triangle()
    }
    
    
    
    
    func evalLevels()
    {
        menuXpos.removeAll()
        menuCount.removeAll()
        
        for i in 0...7 {
            var idx = -1
            var cnt = 0
            var k = 0
            for c in cities {
                if c.s == i {
                    if idx<0 {
                        idx = k
                    }
                    cnt = cnt + 1
                }
                k = k + 1
            }
            menuXpos.append(idx)
            menuCount.append(cnt)
        }
        
        
        print(menuCount)
        
        
    }
    
    
    
    func evalDist(x:CGFloat, y:CGFloat, n:Int)->CGFloat
    {
        var d: CGFloat = 401
        for i in 4..<n {
            let r =  (pts[i].x - x)*(pts[i].x - x)+(pts[i].y - y)*(pts[i].y - y)
            if r<d {
                d = r
            }
        }
        return d
    }
    
    
    func triangle()->[Convex]
    {
        var convexTemp = [Convex]()
        for j in pts.indices {
            let live = pts[j].live
            if  live > 0 {
                let x0 = pts[j].x
                let y0 = pts[j].y
                hull.removeAll()
                var vtx = [PointHull]()
                for i in pts.indices {
                    let x = pts[i].x
                    let y = pts[i].y
                    if i<4 {
                        let p = CGPoint(x: x, y: y)
                        hull.append(MarkedPoint(p:p, flag: i))
                    } else if i != j && live>0 {
                        let u = x-x0
                        let v = y-y0
                        let r = atan2(v, -u)
                        let r2 = 1.0/sqrt(u*u + v*v)
                        vtx.append(PointHull(x:(x+x0)/2,y:(y+y0)/2,u: v*r2,v:-u*r2,angle:r,indx:i))
                    }
                }
                let vtxSorted = vtx.sorted(by:{ $0.angle > $1.angle })
                
                for v in vtxSorted {
                    hullIntersection(vtx: v)
                }
                
                var vp = [CGPoint]()
                let wp = [Weight]()
                
                var temp = [Int]()
                for h in hull {
                    temp.append(h.flag)
                }
                pts[j].nrb = temp
                
                for h in hull {
                    vp.append(h.p)
                }
                vp.append(vp.first!)
                
                convexTemp.append(Convex(vtx:vp, wtf:wp, color:pts[j].color))
                
                
            }
        }
        return convexTemp
    }
    
    
    func intersection2(p3:CGPoint, p4:CGPoint, h:Line)->CGFloat? {
        let d = h.vec.x*(p4.y - p3.y) - h.vec.y*(p4.x - p3.x)
        if d == 0 {
            return nil // parallel lines
        }
        let u = ((p3.x - h.pnt.x)*(p4.y - p3.y) - (p3.y - h.pnt.y)*(p4.x - p3.x))/d
        let v = ((p3.x - h.pnt.x)*h.vec.y - (p3.y - h.pnt.y)*h.vec.x)/d
        if v < 0.0 || v > 1.0 {
            return nil // intersection point not between p3 and p4
        }
        return u
    }
    
    
    func hullIntersection(vtx:PointHull) {
        
        let x = vtx.x + vtx.u * 1024.0
        let y = vtx.y + vtx.v * 1024.0
        let hvec = Line(pnt:CGPoint(x: x, y: y), vec:CGPoint(x: -vtx.u, y: -vtx.v))
        
        var cross = 0
        var i1 = 0
        var i2 = 0
        var t1:CGFloat = 0
        var t2:CGFloat = 0
        for i in hull.indices {
            let j = i<hull.count-1 ? i+1 : 0
            let p1 = hull[i]
            let p2 = hull[j]
            
            if let t = intersection2(p3: p1.p, p4: p2.p, h: hvec) {
                cross = cross + 1
                if cross == 1 {
                    i1 = i
                    t1 = t
                }
                if cross == 2 {
                    i2 = i
                    t2 = t
                }
            }
        }
        
        if cross == 2 {
            if t1>t2 {
                let t = t2
                t2 = t1
                t1 = t
                let i = i2
                i2 = i1
                i1 = i
            }
            let nHull = hull.count
            let x1 = hvec.pnt.x + t1 * hvec.vec.x
            let y1 = hvec.pnt.y + t1 * hvec.vec.y
            let x2 = hvec.pnt.x + t2 * hvec.vec.x
            let y2 = hvec.pnt.y + t2 * hvec.vec.y
            let j = i1<nHull-1 ? i1+1 : 0
            
            let nrb = hull[i2].flag
            let pm1 = MarkedPoint(p: CGPoint(x:x1,y:y1), flag: vtx.indx)
            hull[j] = pm1
            let pm2 = MarkedPoint(p: CGPoint(x:x2,y:y2), flag: nrb)
            if i2 == j {
                hull.insert(pm2, at: j+1)
            } else {
                hull[i2] = pm2
                let j2 = j<nHull-1 ? j+1 : 0
                
                var m = i2 - j2
                
                if m>=0 {
                    while m>0 {
                        hull.remove(at: j2)
                        m = m - 1
                    }
                } else {
                    let m1 = nHull - j2
                    hull.removeLast(m1)
                    hull.removeFirst(i2)
                }
            }
        }
    }
    
}
