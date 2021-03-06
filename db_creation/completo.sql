-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
--
-- Host: localhost    Database: new_gestionale
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ads`
--

DROP TABLE IF EXISTS `ads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(32) NOT NULL,
  `rank` int(11) NOT NULL,
  `visualized` int(11) NOT NULL DEFAULT '0',
  `image_src` varchar(64) NOT NULL,
  `total_visualization` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ads_id_uindex` (`id`),
  UNIQUE KEY `ads_desc_uindex` (`desc`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ads`
--

LOCK TABLES `ads` WRITE;
/*!40000 ALTER TABLE `ads` DISABLE KEYS */;
INSERT INTO `ads` VALUES (1,'sampa',2,2,'/ads/%sampa.png',185);
/*!40000 ALTER TABLE `ads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `answer` varchar(10) DEFAULT NULL,
  `details` varchar(256) DEFAULT NULL,
  `question` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `answers_id_uindex` (`id`),
  KEY `answers_questions_id_fk` (`question`),
  CONSTRAINT `answers_questions_id_fk` FOREIGN KEY (`question`) REFERENCES `questions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(32) DEFAULT NULL,
  `icona` varchar(16) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categoria_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Cassa',''),(2,'Risorse',''),(3,'Amministrazione',''),(4,'Analisi','');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credentials`
--

DROP TABLE IF EXISTS `credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credentials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(32) NOT NULL,
  `passw_hash` varchar(41) NOT NULL,
  `client` varchar(40) DEFAULT NULL,
  `used` int(11) NOT NULL DEFAULT '0',
  `initiate` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `credentials_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=672 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credentials`
--

LOCK TABLES `credentials` WRITE;
/*!40000 ALTER TABLE `credentials` DISABLE KEYS */;
INSERT INTO `credentials` VALUES (664,'rIzXhp2one','9269ad2afefaec39645a7fac29e86b948190eb54',NULL,0,1559114968),(665,'v8a2LcXSyQ','f36d07f761e5f53f3a8bd7f1395e2419e8a1e95e',NULL,0,1559114972),(666,'_q2e8A9HEx','c3e10755d13ed3312b2d496d915dd65ac3aef885',NULL,0,1559114976),(667,'vUiB_mszYF','8cc5e644a94f83ec60d7aad3e4d947f12850c513',NULL,0,1559115045),(668,'Ob5qhD9FYu','cb5204dc47d7a4af699429e8d8fb6653c0475e46',NULL,0,1559115058),(669,'rb75IsS219','05d980d3e31aaa16f481841b86e0441da871a13e',NULL,0,1559115059),(670,'90Uitk3Bhb','fc50526af272f4928f0b9d0eb805eb0a4a1a9900',NULL,0,1559115196),(671,'4pQPAgjPnE','71bdbe67adb72aee40939b4c76941a0fce3d8fa9',NULL,0,1559115224);
/*!40000 ALTER TABLE `credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cupons`
--

DROP TABLE IF EXISTS `cupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cupons` (
  `id` int(11) NOT NULL,
  `tipo` int(11) NOT NULL,
  `valore` float DEFAULT NULL,
  `minimo` float DEFAULT NULL,
  `usato` int(11) NOT NULL DEFAULT '0',
  `valore_venduto` float DEFAULT '0',
  `accettato_usr` varchar(41) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cupons_id_uindex` (`id`),
  KEY `cupons_cupons_types_id_fk` (`tipo`),
  KEY `cupons_utenti_username_fk` (`accettato_usr`),
  CONSTRAINT `cupons_cupons_types_id_fk` FOREIGN KEY (`tipo`) REFERENCES `cupons_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cupons_utenti_username_fk` FOREIGN KEY (`accettato_usr`) REFERENCES `utenti` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cupons`
--

LOCK TABLES `cupons` WRITE;
/*!40000 ALTER TABLE `cupons` DISABLE KEYS */;
INSERT INTO `cupons` VALUES (12547,1,1,0,0,0,'stefano');
/*!40000 ALTER TABLE `cupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cupons_types`
--

DROP TABLE IF EXISTS `cupons_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cupons_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Cupons_types_id_uindex` (`id`),
  UNIQUE KEY `Cupons_types_descrizione_uindex` (`descrizione`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cupons_types`
--

LOCK TABLES `cupons_types` WRITE;
/*!40000 ALTER TABLE `cupons_types` DISABLE KEYS */;
INSERT INTO `cupons_types` VALUES (2,'FIXED'),(1,'FULL'),(3,'PERCENTAGE');
/*!40000 ALTER TABLE `cupons_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `details`
--

DROP TABLE IF EXISTS `details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `json` text NOT NULL,
  `human_dec` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `details_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `details`
--

LOCK TABLES `details` WRITE;
/*!40000 ALTER TABLE `details` DISABLE KEYS */;
INSERT INTO `details` VALUES (1,'{\"display\": false}','NULL'),(3,'{\"display\": true, \"dialog\": {\"choose\": [\"frizzante\", \"naturale\"]}, \"title\": \"Ancora alcuni dettagli...\"}','vini'),(5,'{\"display\": true, \"dialog\": {\"select\": [\"ketchup\", \"senape\", \"mayo\"]}, \"title\": \"Ancora alcuni dettagli...\"}','panini'),(6,'{\"dialog\":{\"choose\":[\"Limone\",\"Pesca\"]},\"display\":true,\"title\":\"Ancora alcuni dettagli...\"}',NULL),(7,'{\"dialog\":{\"choose\":[\"Normale\",\"Mista\"]},\"display\":true,\"title\":\"Ancora alcuni dettagli...\"}',NULL),(8,'{\"dialog\":{\"choose\":[\"Rosso\",\"Bianco\"]},\"display\":true,\"title\":\"Ancora alcuni dettagli...\"}',NULL),(9,'{\"dialog\":{\"choose\":[\"Liscio\",\"Corretto\"]},\"display\":true,\"title\":\"Ancora alcuni dettagli...\"}',NULL);
/*!40000 ALTER TABLE `details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funzioni`
--

DROP TABLE IF EXISTS `funzioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funzioni` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titolo` varchar(64) NOT NULL,
  `descrizione` varchar(64) NOT NULL DEFAULT '',
  `categoria` int(11) DEFAULT NULL,
  `icona` varchar(48) NOT NULL,
  `req_prev` int(11) NOT NULL DEFAULT '0',
  `to` varchar(32) NOT NULL,
  `tooltip` varchar(64) DEFAULT NULL,
  `isPrivate` int(11) NOT NULL DEFAULT '1',
  `isPublic` int(11) NOT NULL DEFAULT '0',
  `moduleName` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `funzioni_id_uindex` (`id`),
  UNIQUE KEY `funzioni_titolo_uindex` (`titolo`),
  KEY `funzioni_categoria_id_fk` (`categoria`),
  KEY `funzioni_previlegi_id_fk` (`req_prev`),
  CONSTRAINT `funzioni_categoria_id_fk` FOREIGN KEY (`categoria`) REFERENCES `categoria` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `funzioni_previlegi_id_fk` FOREIGN KEY (`req_prev`) REFERENCES `previlegi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funzioni`
--

LOCK TABLES `funzioni` WRITE;
/*!40000 ALTER TABLE `funzioni` DISABLE KEYS */;
INSERT INTO `funzioni` VALUES (1,'Cassa','Crea il tuo ordine',1,'fas fa-money-bill-alt',1,'newOrdine',NULL,1,1,'cassa'),(3,'Magazzino','Gestione magazzino e risorse',2,'fas fa-warehouse',5,'magazzino',NULL,1,0,'magazzino'),(5,'Statistiche','Andamenti e incassi',4,'fas fa-chart-bar',7,'stats',NULL,1,0,'statistica'),(7,'Editor','Editor modelli pdf',3,'fas fa-edit',11,'editor',NULL,0,0,'editor'),(9,'Gestione Buoni','Gestisci e crea buoni',3,'fas fa-piggy-bank',3,'buoni',NULL,1,0,'buoni'),(11,'Storico','Storico e gestione ordini',4,'fas fa-history',9,'storico',NULL,1,0,'storico'),(13,'Cassa Self','',1,'fas fa-barcode',1,'self',NULL,1,0,'cassa_self'),(15,'Feedback','Dicci cosa ne pensi',1,'fas fa-comments',1,'guestFeedback',NULL,0,1,'feedback'),(17,'Gestione Ads','Permette di aggiungere, rimuovere e gestire gli advertisement',3,'fas fa-ad',15,'AdsManager',NULL,1,0,'adsmanager'),(19,'Gestione ordini magazzino','Permette di determinare il numero di ordine a seguire',3,'fas fa-sort-numeric-up',15,'OrderOptions',NULL,1,0,'ordermanager'),(21,'Accedi ad Internet','Fai un ordine, puoi navigare gratis!',1,'fas fa-ethernet',1,'nwlogin',NULL,0,1,'networklogin');
/*!40000 ALTER TABLE `funzioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gruppi_cucina`
--

DROP TABLE IF EXISTS `gruppi_cucina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gruppi_cucina` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) NOT NULL,
  `bg` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gruppi_cucina_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gruppi_cucina`
--

LOCK TABLES `gruppi_cucina` WRITE;
/*!40000 ALTER TABLE `gruppi_cucina` DISABLE KEYS */;
INSERT INTO `gruppi_cucina` VALUES (14,'BIBITE','/bg/bibite.jpg'),(15,'ALCOLICI','/bg/alcolici.jpg'),(16,'CAFFÉ','/bg/caffe.jpg'),(17,'PRIMI PIATTI','/bg/pp.jpg'),(18,'SECONDI PIATTI','/bg/sp.jpg'),(19,'FAST FOOD','/bg/food.jpg'),(20,'MENU','/bg/menu.jpg');
/*!40000 ALTER TABLE `gruppi_cucina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `magazzino`
--

DROP TABLE IF EXISTS `magazzino`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `magazzino` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(64) NOT NULL,
  `info` text,
  `giacenza` int(11) NOT NULL DEFAULT '0',
  `prezzoEur` int(11) NOT NULL DEFAULT '0',
  `prezzoCents` int(11) NOT NULL DEFAULT '0',
  `gruppo` int(11) NOT NULL,
  `details` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `magazzino_id_uindex` (`id`),
  KEY `magazzino_gruppi_cucina_id_fk` (`gruppo`),
  KEY `magazzino_details_id_fk` (`details`),
  CONSTRAINT `magazzino_details_id_fk` FOREIGN KEY (`details`) REFERENCES `details` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `magazzino_gruppi_cucina_id_fk` FOREIGN KEY (`gruppo`) REFERENCES `gruppi_cucina` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `magazzino`
--

LOCK TABLES `magazzino` WRITE;
/*!40000 ALTER TABLE `magazzino` DISABLE KEYS */;
INSERT INTO `magazzino` VALUES (32,'Acqua 0.5 l',NULL,999783,0,50,14,3),(33,'Coca-cola',NULL,999852,1,50,14,1),(34,'Aranciata',NULL,999966,1,50,14,1),(35,'Lemonsoda',NULL,999983,1,50,14,1),(36,'Chinotto',NULL,999988,1,50,14,1),(37,'Sprite',NULL,999986,1,50,14,1),(38,'The',NULL,999898,1,50,14,6),(39,'Birra media',NULL,999748,2,50,15,7),(40,'Vino bicchiere',NULL,999979,1,0,15,8),(41,'Vino bottiglia',NULL,999979,6,0,15,8),(42,'Bottiglia bollicine',NULL,999988,15,0,15,1),(43,'Caffè',NULL,999854,1,0,16,9),(44,'Pasta bianca','NULL',1000000,2,0,17,1),(45,'Pasta pomodoro','NULL',1000000,2,50,17,1),(46,'Pasta ragu','NULL',1000000,4,0,17,1),(47,'Gnocchi di pane','NULL',999983,4,0,17,1),(48,'Casoncelli',NULL,999939,4,0,17,1),(49,'Pane e salamella','NULL',999916,2,50,17,1),(50,'Pane e tagliata',NULL,999938,3,50,18,1),(51,'Grigliata mista','NULL',1000000,7,0,18,1),(52,'Costine','NULL',1000000,3,50,18,1),(53,'Tagliata manzo',NULL,999934,7,0,18,1),(54,'Ali pollo','NULL',1000000,3,0,18,1),(55,'Pizza',NULL,999973,2,0,18,1),(56,'Formaggio fuso','NULL',999972,3,0,19,1),(57,'Patatine','NULL',999842,2,0,19,1),(61,'Menu 1912','',999958,10,0,17,1),(62,'Foodball-baby1','',999901,5,0,17,1),(63,'Foodball-baby2','',999990,5,0,17,1),(64,'Amaro','',999985,2,0,15,1);
/*!40000 ALTER TABLE `magazzino` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordini_dettagli`
--

DROP TABLE IF EXISTS `ordini_dettagli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordini_dettagli` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_distict` varchar(60) NOT NULL,
  `ordnum` varchar(10) NOT NULL,
  `message` text,
  `asporto` int(11) NOT NULL,
  `client` varchar(20) DEFAULT NULL,
  `timestamp` int(11) NOT NULL,
  `user` varchar(32) NOT NULL DEFAULT 'admin',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ordini_dettagli_id_uindex` (`id`),
  KEY `ordini_dettagli_utenti_username_fk` (`user`),
  CONSTRAINT `ordini_dettagli_utenti_username_fk` FOREIGN KEY (`user`) REFERENCES `utenti` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=852 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordini_dettagli`
--

LOCK TABLES `ordini_dettagli` WRITE;
/*!40000 ALTER TABLE `ordini_dettagli` DISABLE KEYS */;
INSERT INTO `ordini_dettagli` VALUES (851,'----','0000','',0,'--',0,'reprint');
/*!40000 ALTER TABLE `ordini_dettagli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordini_prodotti`
--

DROP TABLE IF EXISTS `ordini_prodotti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordini_prodotti` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order` int(11) NOT NULL,
  `product` int(11) NOT NULL,
  `variant` text,
  `qta` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ordini_prodotti_id_uindex` (`id`),
  KEY `ordini_prodotti_ordini_dettagli_id_fk` (`order`),
  KEY `ordini_prodotti_magazzino_id_fk` (`product`),
  CONSTRAINT `ordini_prodotti_magazzino_id_fk` FOREIGN KEY (`product`) REFERENCES `magazzino` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ordini_prodotti_ordini_dettagli_id_fk` FOREIGN KEY (`order`) REFERENCES `ordini_dettagli` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1588 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordini_prodotti`
--

LOCK TABLES `ordini_prodotti` WRITE;
/*!40000 ALTER TABLE `ordini_prodotti` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordini_prodotti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `previlegi`
--

DROP TABLE IF EXISTS `previlegi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `previlegi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `abilities_id_uindex` (`id`),
  UNIQUE KEY `abilities_description_uindex` (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `previlegi`
--

LOCK TABLES `previlegi` WRITE;
/*!40000 ALTER TABLE `previlegi` DISABLE KEYS */;
INSERT INTO `previlegi` VALUES (15,'AMMINISTRAZIONE'),(3,'BUONI'),(1,'CASSA'),(11,'EDITOR'),(5,'MAGAZZINO'),(7,'STATISTICHE'),(9,'STORICO'),(13,'UTENTI');
/*!40000 ALTER TABLE `previlegi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_type`
--

DROP TABLE IF EXISTS `question_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `question_type_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_type`
--

LOCK TABLES `question_type` WRITE;
/*!40000 ALTER TABLE `question_type` DISABLE KEYS */;
INSERT INTO `question_type` VALUES (1,'YESNO'),(2,'STARS'),(3,'EMPTY');
/*!40000 ALTER TABLE `question_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `testo` text NOT NULL,
  `answerType` int(11) NOT NULL,
  `details` int(11) NOT NULL,
  `title` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `questions_id_uindex` (`id`),
  KEY `questions_question_type_id_fk` (`answerType`),
  CONSTRAINT `questions_question_type_id_fk` FOREIGN KEY (`answerType`) REFERENCES `question_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,'Domanda 1?',1,1,'Domanda1'),(3,'Domanda 2?',2,0,'Domanda2'),(5,'Domanda 3?',3,0,'Domanda3');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utenti`
--

DROP TABLE IF EXISTS `utenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utenti` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(41) NOT NULL,
  `name` varchar(32) NOT NULL,
  `secure` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `admin` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `utenti_id_uindex` (`id`),
  UNIQUE KEY `utenti_username_uindex` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utenti`
--

LOCK TABLES `utenti` WRITE;
/*!40000 ALTER TABLE `utenti` DISABLE KEYS */;
INSERT INTO `utenti` VALUES (1,'stefano','2866093772d6f50c923fb6a19f976bb22e87124c','Stefano',1,1,1),(5,'luca','f9c0f8b91180c7d93028c79ef4993e4d5a5b3e59','Luca',1,1,1),(13,'reprint','unloggable','reprint',1,0,0),(15,'Operator Self','unloggable','Operator Self',1,0,0),(18,'Pier','f99d8be996c99473ba19e62ad2cf38e1aa53fdef','Pierangelo',1,1,1),(19,'Matteo','1951e5324992898d317277a86eadbdb3f7456bda','Matteo',1,1,0),(20,'Luisa','e7097cce199f6eda0670bf5c2486f94d18406983','Luisa',1,1,0),(21,'Elena','4d9936f16aad50c361705eb5f56741b655b27576','Elena',1,1,0);
/*!40000 ALTER TABLE `utenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utenti_previlegi_assoc`
--

DROP TABLE IF EXISTS `utenti_previlegi_assoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utenti_previlegi_assoc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `utenti_FOREGIN` int(11) NOT NULL,
  `previlegi_FOREGIN` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `utenti_previlegi_assoc_id_uindex` (`id`),
  KEY `utenti_previlegi_assoc_previlegi_id_fk` (`previlegi_FOREGIN`),
  KEY `utenti_previlegi_assoc_abilities_id_fk` (`utenti_FOREGIN`),
  CONSTRAINT `utenti_previlegi_assoc_abilities_id_fk` FOREIGN KEY (`utenti_FOREGIN`) REFERENCES `utenti` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utenti_previlegi_assoc_previlegi_id_fk` FOREIGN KEY (`previlegi_FOREGIN`) REFERENCES `previlegi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utenti_previlegi_assoc`
--

LOCK TABLES `utenti_previlegi_assoc` WRITE;
/*!40000 ALTER TABLE `utenti_previlegi_assoc` DISABLE KEYS */;
INSERT INTO `utenti_previlegi_assoc` VALUES (113,1,15),(115,1,3),(117,1,1),(119,1,11),(121,1,5),(123,1,7),(125,1,9),(127,1,13),(160,5,15),(161,5,3),(162,5,1),(163,5,11),(164,5,5),(165,5,7),(166,5,9),(167,5,13),(169,18,15),(170,18,3),(171,18,1),(172,18,11),(173,18,5),(174,18,7),(175,18,9),(176,18,13),(177,19,1),(178,20,1),(179,21,1);
/*!40000 ALTER TABLE `utenti_previlegi_assoc` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-29 10:38:30
