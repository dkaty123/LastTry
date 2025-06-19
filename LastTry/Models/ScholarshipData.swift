import Foundation

struct ScholarshipData {
    static func convertAndAddScholarships() -> [Scholarship] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        
        var scholarships: [Scholarship] = []
        
        // Convert string dates to Date objects
        let scholarTreeDate = dateFormatter.date(from: "December 31, 2024")!
        let hockeyHospiceDate = dateFormatter.date(from: "May 31, 2025")!
        let smartServeDate = dateFormatter.date(from: "June 30, 2025")!
        let northCoverDate = dateFormatter.date(from: "July 15, 2025")!
        let canAchieveDate = dateFormatter.date(from: "August 15, 2025")!
        let laTutorsDate = dateFormatter.date(from: "September 30, 2025")!
        let goTranscriptDate = dateFormatter.date(from: "October 31, 2025")!
        let russellAlexanderDate = dateFormatter.date(from: "November 30, 2025")!
        let grainFarmersDate = dateFormatter.date(from: "July 20, 2025")!
        let haywoodHuntDate = dateFormatter.date(from: "August 31, 2025")!
        let brandonLanghjelmDate = dateFormatter.date(from: "October 27, 2025")!
        let coverGuyDate = dateFormatter.date(from: "January 14, 2026")!
        let empoweredKidsDate = dateFormatter.date(from: "December 11, 2025")!
        let jeromeHenryDate = dateFormatter.date(from: "January 8, 2026")!
        let assumptionLifeDate = dateFormatter.date(from: "January 8, 2026")!
        let w2roDate = dateFormatter.date(from: "January 29, 2026")!
        let brainTumourDate = dateFormatter.date(from: "February 1, 2026")!
        let herbalandDate = dateFormatter.date(from: "June 30, 2025")!
        
        // New scholarship dates
        let otipDate = dateFormatter.date(from: "December 4, 2025")!
        let ticDate = dateFormatter.date(from: "December 4, 2025")!
        let foundationDate = dateFormatter.date(from: "December 4, 2025")!
        let assumptionLifeNewDate = dateFormatter.date(from: "January 1, 2026")!
        let fraserDate = dateFormatter.date(from: "February 5, 2026")!
        let iwshDate = dateFormatter.date(from: "February 5, 2026")!
        let yconicDate = dateFormatter.date(from: "July 31, 2025")!
        let embarkDate = dateFormatter.date(from: "December 31, 2025")!
        let cibcDate = dateFormatter.date(from: "June 30, 2025")!
        let villaCharitiesDate = dateFormatter.date(from: "June 30, 2025")!
        let bmoDate = dateFormatter.date(from: "January 31, 2026")!
        let unileverDate = dateFormatter.date(from: "August 1, 2025")!
        let goodwillDate = dateFormatter.date(from: "October 15, 2025")!
        let bloodServicesDate = dateFormatter.date(from: "August 30, 2025")!
        let onecaDate = dateFormatter.date(from: "June 30, 2025")!
        let schulichDate = dateFormatter.date(from: "August 14, 2025")!
        let northernStudiesDate = dateFormatter.date(from: "November 1, 2025")!
        let futureInfoSecDate = dateFormatter.date(from: "January 15, 2026")!
        let nshssDate = dateFormatter.date(from: "November 6, 2025")!
        let isc2Date = dateFormatter.date(from: "January 14, 2026")!
        let pinskyDate = dateFormatter.date(from: "August 14, 2025")!
        let bankOfCanadaDate = dateFormatter.date(from: "March 13, 2026")!
        let futureOfPlayDate = dateFormatter.date(from: "June 13, 2025")!
        let voiceTalentDate = dateFormatter.date(from: "September 18, 2025")!
        let terryFoxDate = dateFormatter.date(from: "November 3, 2025")!
        let bettsDate = dateFormatter.date(from: "December 11, 2025")!
        let rbcDate = dateFormatter.date(from: "December 11, 2025")!
        let mensaDate = dateFormatter.date(from: "October 14, 2025")!
        let rhodesDate = dateFormatter.date(from: "June 4, 2025")!
        let youngMiningDate = dateFormatter.date(from: "June 18, 2025")!
        let atlasShruggedDate = dateFormatter.date(from: "July 19, 2025")!
        let confidentWritersDate = dateFormatter.date(from: "August 9, 2025")!
        let storwellDate = dateFormatter.date(from: "December 31, 2025")!
        let northwestelDate = dateFormatter.date(from: "July 2, 2025")!
        let seiuDate = dateFormatter.date(from: "June 27, 2025")!
        let bcFirstNationsDate = dateFormatter.date(from: "August 1, 2025")!
        let womensVoteDate = dateFormatter.date(from: "October 31, 2025")!
        let cwbDate = dateFormatter.date(from: "June 13, 2025")!
        let hensallDate = dateFormatter.date(from: "August 1, 2025")!
        let blackGirlHockeyDate = dateFormatter.date(from: "June 30, 2025")!
        let cnPensionersDate = dateFormatter.date(from: "August 13, 2025")!
        
        // New scholarship dates
        let osuuspankkiDate = dateFormatter.date(from: "September 30, 2025")!
        let belairdirectDate = dateFormatter.date(from: "July 15, 2025")!
        let billMasonDate = dateFormatter.date(from: "September 30, 2025")!
        let horatioAlgerDate = dateFormatter.date(from: "August 1, 2025")!
        let fulbrightDate = dateFormatter.date(from: "November 15, 2025")!
        let nshssEducatorsDate = dateFormatter.date(from: "August 18, 2025")!
        let cnibDate = dateFormatter.date(from: "June 28, 2025")!
        let simmentalDate = dateFormatter.date(from: "September 30, 2025")!
        let castleTradeDate = dateFormatter.date(from: "August 15, 2025")!
        let mrooDate = dateFormatter.date(from: "September 5, 2025")!
        let nshssHeroDate = dateFormatter.date(from: "August 18, 2025")!
        let strikeLgbtqDate = dateFormatter.date(from: "June 30, 2025")!
        let strikeIndigenousDate = dateFormatter.date(from: "June 30, 2025")!
        let meLauDate = dateFormatter.date(from: "June 30, 2025")!
        let mihrDate = dateFormatter.date(from: "September 30, 2025")!
        let citizensFoundationDate = dateFormatter.date(from: "August 15, 2025")!
        let curlingDate = dateFormatter.date(from: "June 9, 2025")!
        let psacDate = dateFormatter.date(from: "June 23, 2025")!
        let bill7Date = dateFormatter.date(from: "August 1, 2025")!
        let brianMaxwellDate = dateFormatter.date(from: "June 9, 2025")!
        let uniforDate = dateFormatter.date(from: "June 20, 2025")!
        let ccohsDate = dateFormatter.date(from: "August 31, 2025")!
        let metalSupermarketsDate = dateFormatter.date(from: "June 27, 2025")!
        let spinMasterDate = dateFormatter.date(from: "June 13, 2025")!
        
        // New scholarship dates
        let mikePuhalloDate = dateFormatter.date(from: "December 31, 2025")!
        let modernMetisDate = dateFormatter.date(from: "October 31, 2025")!
        let ufcwDate = dateFormatter.date(from: "September 30, 2025")!
        let cawicDate = dateFormatter.date(from: "June 26, 2025")!
        let youngFarmersDate = dateFormatter.date(from: "June 30, 2025")!
        let whscDate = dateFormatter.date(from: "July 23, 2025")!
        let supportTroopsDate = dateFormatter.date(from: "July 17, 2025")!
        let ethelBoyceDate = dateFormatter.date(from: "September 15, 2025")!
        let castagraDate = dateFormatter.date(from: "August 29, 2025")!
        let opterusArtsDate = dateFormatter.date(from: "June 13, 2025")!
        let opterusStemDate = dateFormatter.date(from: "June 13, 2025")!
        let alliedVanLinesDate = dateFormatter.date(from: "December 15, 2025")!
        let bluEarthDate = dateFormatter.date(from: "September 15, 2025")!
        let resourceAbilitiesDate = dateFormatter.date(from: "June 30, 2025")!
        let peiFoundationDate = dateFormatter.date(from: "June 30, 2025")!
        
        // New scholarship dates
        let bigSunDate = dateFormatter.date(from: "June 19, 2025")!
        let sgiResearchDate = dateFormatter.date(from: "September 30, 2025")!
        let sgiHamiltonDate = dateFormatter.date(from: "October 31, 2025")!
        let abbVieDate = dateFormatter.date(from: "June 9, 2025")!
        let fwioDate = dateFormatter.date(from: "June 30, 2025")!
        let valourCanadaDate = dateFormatter.date(from: "June 11, 2025")!
        let northAmericanDate = dateFormatter.date(from: "December 15, 2025")!
        let disabilityCreditDate = dateFormatter.date(from: "July 31, 2025")!
        let moneyGeniusDate = dateFormatter.date(from: "October 3, 2025")!
        let mccallMacBainDate = dateFormatter.date(from: "September 24, 2025")!
        let monSheongDate = dateFormatter.date(from: "July 7, 2025")!
        let rugbyFoundationDate = dateFormatter.date(from: "September 1, 2025")!
        
        // New scholarship dates
        let thomasFamilyDate = dateFormatter.date(from: "September 1, 2025")!
        let aiaCanadaDate = dateFormatter.date(from: "June 15, 2025")!
        let leliefonteinDate = dateFormatter.date(from: "September 19, 2025")!
        let mjtDate = dateFormatter.date(from: "September 30, 2025")!
        let aesEngineeringDate = dateFormatter.date(from: "October 8, 2025")!
        let loranDate = dateFormatter.date(from: "October 15, 2025")!
        let photoshopDate = dateFormatter.date(from: "October 15, 2025")!
        let americanMuscleDate = dateFormatter.date(from: "June 15, 2025")!
        let eatonDate = dateFormatter.date(from: "October 31, 2025")!
        let jccfDate = dateFormatter.date(from: "October 27, 2025")!
        let tdDate = dateFormatter.date(from: "November 13, 2025")!
        let driverEducationDate = dateFormatter.date(from: "November 30, 2025")!
        let smoothMoversDate = dateFormatter.date(from: "November 30, 2025")!
        let indspireDate = dateFormatter.date(from: "November 1, 2025")!
        let soroptimistDate = dateFormatter.date(from: "November 15, 2025")!
        let kidneyFoundationDate = dateFormatter.date(from: "November 15, 2025")!
        let odenzaDate = dateFormatter.date(from: "November 15, 2025")!
        
        // New scholarship dates
        let nutrienDate = dateFormatter.date(from: "November 25, 2025")!
        let judyCameronDate = dateFormatter.date(from: "November 30, 2025")!
        let arthurPaulinDate = dateFormatter.date(from: "November 30, 2025")!
        let osstfDate = dateFormatter.date(from: "November 15, 2025")!
        let heerLawDate = dateFormatter.date(from: "December 31, 2025")!
        let dewaltDate = dateFormatter.date(from: "January 16, 2025")!
        let gulabOilsDate = dateFormatter.date(from: "January 15, 2025")!
        let dickMartinDate = dateFormatter.date(from: "January 31, 2025")!
        let burgerKingDate = dateFormatter.date(from: "December 16, 2025")!
        let launchpadDate = dateFormatter.date(from: "December 3, 2025")!
        let orbaCollegeDate = dateFormatter.date(from: "December 5, 2025")!
        let orbaUniversityDate = dateFormatter.date(from: "December 5, 2025")!
        let automotiveWomenDate = dateFormatter.date(from: "December 31, 2025")!
        let frenchEssayDate = dateFormatter.date(from: "December 20, 2025")!
        let angusDate = dateFormatter.date(from: "January 5, 2025")!
        let johnEvansDate = dateFormatter.date(from: "January 29, 2025")!
        let orangeScholarsDate = dateFormatter.date(from: "January 17, 2025")!
        let childrensAidDate = dateFormatter.date(from: "January 24, 2025")!
        let donBossiDate = dateFormatter.date(from: "January 31, 2025")!
        let ppaoDate = dateFormatter.date(from: "January 31, 2025")!
        let womenStemDate = dateFormatter.date(from: "January 31, 2025")!
        let kinCanadaDate = dateFormatter.date(from: "February 1, 2025")!
        let mcclennanDate = dateFormatter.date(from: "February 1, 2025")!
        let smeDate = dateFormatter.date(from: "February 1, 2025")!
        let safetyJusticeDate = dateFormatter.date(from: "February 1, 2025")!
        let kaySansomDate = dateFormatter.date(from: "February 1, 2025")!
        let rbcFutureDate = dateFormatter.date(from: "February 5, 2025")!
        let omhaDate = dateFormatter.date(from: "February 16, 2025")!
        let tedRogersDate = dateFormatter.date(from: "February 26, 2025")!
        let silverSpringDate = dateFormatter.date(from: "February 28, 2025")!
        let millieBrotherDate = dateFormatter.date(from: "February 28, 2025")!
        
        // New scholarship dates
        let optimistDate = dateFormatter.date(from: "February 28, 2025")!
        let tallClubsDate = dateFormatter.date(from: "March 1, 2025")!
        let remaxDate = dateFormatter.date(from: "March 9, 2025")!
        let lionelDate = dateFormatter.date(from: "March 1, 2025")!
        let allanSimpsonDate = dateFormatter.date(from: "March 1, 2025")!
        let boilermakerDate = dateFormatter.date(from: "March 1, 2025")!
        let hoffaDate = dateFormatter.date(from: "March 1, 2025")!
        let diabetesHopeDate = dateFormatter.date(from: "March 3, 2025")!
        let copaDate = dateFormatter.date(from: "March 14, 2025")!
        let stJohnDate = dateFormatter.date(from: "March 15, 2025")!
        let ucuDate = dateFormatter.date(from: "March 24, 2025")!
        let girlGuidesDate = dateFormatter.date(from: "March 25, 2025")!
        let retailDate = dateFormatter.date(from: "March 28, 2025")!
        let jamieHubleyDate = dateFormatter.date(from: "March 31, 2025")!
        let manulifeDate = dateFormatter.date(from: "March 31, 2025")!
        let kochharDate = dateFormatter.date(from: "March 31, 2025")!
        let kindnessDate = dateFormatter.date(from: "March 31, 2025")!
        let beartDate = dateFormatter.date(from: "April 1, 2025")!

                let g3GrowBeyondDate = dateFormatter.date(from: "April 9, 2025")!
        let prettyPresetsDate = dateFormatter.date(from: "April 15, 2025")!
        let cpBursariesDate = Date() // TBD
        let globalLiftDate = dateFormatter.date(from: "April 15, 2025")!
        let lynchGettyDate = dateFormatter.date(from: "April 17, 2025")!
        let seanJacksonDate = dateFormatter.date(from: "April 30, 2025")!
        let aeaDate = dateFormatter.date(from: "April 1, 2025")!
        let investintechDate = dateFormatter.date(from: "April 11, 2025")!
        let growmarkDate = dateFormatter.date(from: "April 11, 2025")!
        let brandonWalliDate = dateFormatter.date(from: "April 11, 2025")!
        let limeConnectDate = dateFormatter.date(from: "April 15, 2025")!
        let canadianBatesDate = dateFormatter.date(from: "April 16, 2025")!
        let easterSealsDate = dateFormatter.date(from: "April 17, 2025")!
        let actuonixDate = dateFormatter.date(from: "April 19, 2025")!
        let wendellKingDate = dateFormatter.date(from: "April 20, 2025")!
        let ontarioTrusteeDate = dateFormatter.date(from: "April 25, 2025")!
        let jamesKreppnerDate = dateFormatter.date(from: "April 30, 2025")!
        let edBitzDate = dateFormatter.date(from: "April 30, 2025")!
        let troop17Date = dateFormatter.date(from: "April 30, 2025")!
        let oppYouthDate = dateFormatter.date(from: "April 30, 2025")!
        let caraBrownDate = dateFormatter.date(from: "April 30, 2025")!
        let childhoodCancerDate = dateFormatter.date(from: "April 30, 2025")!
        let autismOntarioDate = dateFormatter.date(from: "April 30, 2025")!
        let smileBursariesDate = dateFormatter.date(from: "April 30, 2025")!
        let liftPartsExpressDate = dateFormatter.date(from: "April 30, 2025")!
        let forestersFinancialDate = dateFormatter.date(from: "April 30, 2025")!
        let bayerCropScienceDate = dateFormatter.date(from: "April 30, 2025")!
        let edcDate = dateFormatter.date(from: "April 30, 2025")!
        let youngGassersDate = dateFormatter.date(from: "April 30, 2025")!
        let jackMacDonaldDate = dateFormatter.date(from: "April 5, 2025")!
        let leavittMachineryDate = dateFormatter.date(from: "May 1, 2025")!
        let odenzaVacationsDate = dateFormatter.date(from: "May 1, 2025")!
        let ilanaRubinDate = dateFormatter.date(from: "May 2, 2025")!
        let loblawDate = dateFormatter.date(from: "May 4, 2025")!

        
        // Add existing scholarships
        scholarships.append(contentsOf: [
            Scholarship(name: "ScholarTree $1000 Giveaway Scholarship",
                       amount: 1000,
                       deadline: scholarTreeDate,
                       description: "Monthly scholarship giveaway for students.",
                       category: .general,
                       requirements: ["Open to all students"]),
            
            Scholarship(name: "Hockey For Hospice Scholarship",
                       amount: 1000,
                       deadline: hockeyHospiceDate,
                       description: "For students involved in hockey and community service.",
                       category: .general,
                       requirements: ["Hockey player", "Community service"]),
            
            Scholarship(name: "Smart Serve Cares Scholarship",
                       amount: 1000,
                       deadline: smartServeDate,
                       description: "For students in hospitality and tourism.",
                       category: .business,
                       requirements: ["Smart Serve certification"]),
            
            Scholarship(name: "North Cover Futures Scholarship",
                       amount: 1000,
                       deadline: northCoverDate,
                       description: "Supporting future leaders in business.",
                       category: .business,
                       requirements: ["Business major"]),
            
            Scholarship(name: "Can-Achieve Education & Culture Inc. Scholarship",
                       amount: 1000,
                       deadline: canAchieveDate,
                       description: "For students promoting cultural diversity.",
                       category: .humanities,
                       requirements: ["Cultural involvement"]),
            
            Scholarship(name: "LA Tutors Monthly Innovation in Education Scholarship",
                       amount: 1000,
                       deadline: laTutorsDate,
                       description: "For innovative educational projects.",
                       category: .general,
                       requirements: ["Project proposal"]),
            
            Scholarship(name: "GoTranscript Academic Scholarship Program",
                       amount: 1000,
                       deadline: goTranscriptDate,
                       description: "For students in transcription and translation.",
                       category: .humanities,
                       requirements: ["Language proficiency"]),
            
            Scholarship(name: "Russell Alexander Law Scholarship",
                       amount: 1000,
                       deadline: russellAlexanderDate,
                       description: "For future legal professionals.",
                       category: .humanities,
                       requirements: ["Law school applicant"]),
            
            // Add new scholarships
            Scholarship(name: "Grain Farmers of Ontario Legacy Scholarship",
                       amount: 5000,
                       deadline: grainFarmersDate,
                       description: "Supporting students in Ontario pursuing agricultural studies.",
                       category: .stem,
                       requirements: ["Ontario resident"]),
            
            Scholarship(name: "Haywood Hunt & Associates Inc. Scholarship",
                       amount: 2500,
                       deadline: haywoodHuntDate,
                       description: "For students pursuing legal or investigative studies.",
                       category: .humanities,
                       requirements: ["Canadian citizen/PR"]),
            
            Scholarship(name: "The Brandon Langhjelm Essay Contest",
                       amount: 2000,
                       deadline: brandonLanghjelmDate,
                       description: "Essay contest on legal and social issues.",
                       category: .humanities,
                       requirements: ["Canadian citizen/PR", "Essay submission required"]),
            
            Scholarship(name: "The Cover Guy Annual Scholarship",
                       amount: 500,
                       deadline: coverGuyDate,
                       description: "For students pursuing higher education.",
                       category: .general,
                       requirements: ["Open to all students"]),
            
            Scholarship(name: "The Empowered Kids Ontario Scholarship Program",
                       amount: 3000,
                       deadline: empoweredKidsDate,
                       description: "For students with disabilities in Ontario.",
                       category: .general,
                       requirements: ["Ontario resident"]),
            
            Scholarship(name: "Jerome Henry Foundation Scholarship",
                       amount: 1000,
                       deadline: jeromeHenryDate,
                       description: "For students demonstrating academic excellence.",
                       category: .general,
                       requirements: ["70-100% average", "Ontario resident"]),
            
            Scholarship(name: "Assumption Life Bursaries",
                       amount: 1500,
                       deadline: assumptionLifeDate,
                       description: "For students in Atlantic Canada.",
                       category: .general,
                       requirements: ["70-100% average"]),
            
            Scholarship(name: "W2RO Scholarship Program",
                       amount: 2000,
                       deadline: w2roDate,
                       description: "For students pursuing higher education.",
                       category: .general,
                       requirements: ["Canadian citizen/PR"]),
            
            Scholarship(name: "Brain Tumour Foundation Youth Education Awards",
                       amount: 5000,
                       deadline: brainTumourDate,
                       description: "For young brain tumour survivors.",
                       category: .general,
                       requirements: ["Ages 16-30"]),
            
            Scholarship(name: "Herbaland Sustainable Lifestyle Scholarship",
                       amount: 1000,
                       deadline: herbalandDate,
                       description: "For students passionate about sustainability.",
                       category: .stem,
                       requirements: ["Open to all students"]),
            
            Scholarship(name: "OTIP Bursary Program",
                       amount: 1500,
                       deadline: otipDate,
                       description: "For OTIP policyholders and their families.",
                       category: .general,
                       requirements: ["OTIP policyholder or family member"]),
            
            Scholarship(name: "TIC Annual Scholarship Program",
                       amount: 3500,
                       deadline: ticDate,
                       description: "For students entering the insurance industry.",
                       category: .business,
                       requirements: ["Interest in insurance career"]),
            
            Scholarship(name: "Foundation Scholarships",
                       amount: 2500,
                       deadline: foundationDate,
                       description: "For current or former Crown wards.",
                       category: .general,
                       requirements: ["Current/former Crown ward", "Under 26 years old"]),
            
            Scholarship(name: "Assumption Life Scholarship",
                       amount: 1500,
                       deadline: assumptionLifeNewDate,
                       description: "For students in Atlantic Canada.",
                       category: .general,
                       requirements: ["Open to all students"]),
            
            Scholarship(name: "Fraser Institute Student Essay Contest",
                       amount: 1000,
                       deadline: fraserDate,
                       description: "Essay contest on public policy issues.",
                       category: .humanities,
                       requirements: ["Open to all students"]),
            
            Scholarship(name: "IWSH ESSAY SCHOLARSHIP CONTEST",
                       amount: 1000,
                       deadline: iwshDate,
                       description: "Essay contest on water and sanitation issues.",
                       category: .stem,
                       requirements: ["Open to all students"]),
            
            Scholarship(name: "yconic Student Award",
                       amount: 5000,
                       deadline: yconicDate,
                       description: "Open to all Canadian students pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Canadian citizen or permanent resident", "Enrolled in or accepted to a post-secondary institution"]),
            
            Scholarship(name: "Embark RESP Contest",
                       amount: 15000,
                       deadline: embarkDate,
                       description: "Enter for a chance to win towards your education.",
                       category: .general,
                       requirements: ["Canadian resident", "No purchase necessary"]),
            
            Scholarship(name: "CIBC Tuition Contest",
                       amount: 10000,
                       deadline: cibcDate,
                       description: "Win tuition money for your post-secondary education.",
                       category: .general,
                       requirements: ["Canadian resident", "18+ years old"]),
            
            Scholarship(name: "Villa Charities Undergraduate Scholarship",
                       amount: 1000,
                       deadline: villaCharitiesDate,
                       description: "For undergraduate students of Italian heritage.",
                       category: .general,
                       requirements: ["Canadian citizen or permanent resident", "Minimum 75% average"]),
            
            Scholarship(name: "Villa Charities Graduate Scholarship",
                       amount: 2000,
                       deadline: villaCharitiesDate,
                       description: "For graduate students of Italian heritage.",
                       category: .general,
                       requirements: ["Canadian citizen or permanent resident", "Enrolled in graduate studies"]),
            
            Scholarship(name: "BMO Student Award",
                       amount: 10000,
                       deadline: bmoDate,
                       description: "For students demonstrating leadership and community involvement.",
                       category: .general,
                       requirements: ["Canadian resident", "Full-time student"]),
            
            Scholarship(name: "Unilever Voices for Change Scholarship",
                       amount: 2000,
                       deadline: unileverDate,
                       description: "For students committed to making a positive social or environmental impact.",
                       category: .general,
                       requirements: ["Canadian resident", "Ages 18-24"]),
            
            Scholarship(name: "Goodwill Industries of Alberta Scholarship",
                       amount: 2500,
                       deadline: goodwillDate,
                       description: "For students who have overcome significant challenges.",
                       category: .general,
                       requirements: ["Alberta resident", "Demonstrated financial need"]),
            
            Scholarship(name: "Canadian Blood Services Scholarship",
                       amount: 9000,
                       deadline: bloodServicesDate,
                       description: "For students who have made significant contributions to their communities.",
                       category: .general,
                       requirements: ["Canadian citizen or permanent resident", "Minimum 80% average"]),
            
            Scholarship(name: "ONECA Four Directions Scholarship",
                       amount: 1000,
                       deadline: onecaDate,
                       description: "For Indigenous students pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Status/Non-status/Inuit/Métis", "Minimum 70% average"]),
            
            Scholarship(name: "Schulich Leader Scholarship",
                       amount: 25000,
                       deadline: schulichDate,
                       description: "Canada's most coveted undergraduate STEM scholarship program.",
                       category: .stem,
                       requirements: ["STEM field of study", "Academic excellence", "Entrepreneurial leadership"]),
            
            Scholarship(name: "Canadian Northern Studies Trust",
                       amount: 3000,
                       deadline: northernStudiesDate,
                       description: "Supporting students in STEM fields with a focus on northern studies.",
                       category: .stem,
                       requirements: ["STEM field of study"]),
            
            Scholarship(name: "FUTURE INFORMATION SECURITY PROFESSIONALS",
                       amount: 5000,
                       deadline: futureInfoSecDate,
                       description: "For students pursuing careers in information security.",
                       category: .stem,
                       requirements: ["Computer Science/IT/IS major", "3.0+ GPA", "Interest in cybersecurity"]),
            
            Scholarship(name: "NSHSS Innovation in Technology Scholarship",
                       amount: 2000,
                       deadline: nshssDate,
                       description: "For students pursuing technology-related fields.",
                       category: .stem,
                       requirements: ["Computer Science major", "Grade 12-3rd year", "3.0+ GPA"]),
            
            Scholarship(name: "ISC2 SCHOLARSHIPS",
                       amount: 5000,
                       deadline: isc2Date,
                       description: "Supporting future cybersecurity professionals.",
                       category: .stem,
                       requirements: ["Computer Science major", "3.0+ GPA", "Interest in cybersecurity"]),
            
            Scholarship(name: "Pinsky Law New Venture Development Scholarship",
                       amount: 5000,
                       deadline: pinskyDate,
                       description: "For entrepreneurial students looking to start their own business.",
                       category: .business,
                       requirements: ["Business plan submission", "Entrepreneurial spirit"]),
            
            Scholarship(name: "Bank of Canada Scholarship",
                       amount: 8000,
                       deadline: bankOfCanadaDate,
                       description: "For students in business, computer science, or economics.",
                       category: .business,
                       requirements: ["1st year to post-grad", "3.0+ GPA"]),
            
            Scholarship(name: "Future of Play Scholarship Program",
                       amount: 12000,
                       deadline: futureOfPlayDate,
                       description: "For students pursuing creative digital media fields.",
                       category: .arts,
                       requirements: ["Animation/Design/Game Dev major", "Portfolio submission"]),
            
            Scholarship(name: "Voice Talent Online Scholarship",
                       amount: 1000,
                       deadline: voiceTalentDate,
                       description: "For students interested in voice acting and media production.",
                       category: .arts,
                       requirements: ["Open to all students"]),
            
            Scholarship(name: "The Terry Fox Humanitarian Awards",
                       amount: 28000,
                       deadline: terryFoxDate,
                       description: "Recognizing humanitarian service and academic achievement.",
                       category: .general,
                       requirements: ["65-100% average", "Significant volunteer work", "Canadian citizen/PR"]),
            
            Scholarship(name: "John E. Betts 'Beat Yesterday' Scholarship",
                       amount: 2500,
                       deadline: bettsDate,
                       description: "For students demonstrating perseverance and community involvement.",
                       category: .general,
                       requirements: ["Grade 12-4th year", "70-100% average"]),
            
            Scholarship(name: "The RBC Future Launch Scholarship",
                       amount: 1500,
                       deadline: rbcDate,
                       description: "Supporting the next generation of Canadian leaders.",
                       category: .general,
                       requirements: ["75-100% average", "Canadian citizen/PR"]),
            
            Scholarship(name: "Mensa Canada Scholarship",
                       amount: 2000,
                       deadline: mensaDate,
                       description: "For students who demonstrate academic excellence.",
                       category: .general,
                       requirements: ["Exceptional academic record", "Canadian citizen/PR"]),
            
            Scholarship(name: "The Rhodes Scholarships for Canada",
                       amount: 10000,
                       deadline: rhodesDate,
                       description: "One of the world's most prestigious scholarships.",
                       category: .general,
                       requirements: ["Academic excellence", "Leadership potential"]),
            
            Scholarship(name: "Young Mining Professionals Scholarship",
                       amount: 2500,
                       deadline: youngMiningDate,
                       description: "Supporting students in mining-related fields.",
                       category: .stem,
                       requirements: ["Mining/Business/Engineering major"]),
            
            Scholarship(name: "Atlas Shrugged Essay Contest",
                       amount: 3000,
                       deadline: atlasShruggedDate,
                       description: "Essay contest based on Ayn Rand's novel.",
                       category: .humanities,
                       requirements: ["Open to all students", "Essay submission required"]),
            
            Scholarship(name: "Confident Writers Scholarship Essay Contest",
                       amount: 750,
                       deadline: confidentWritersDate,
                       description: "For students who demonstrate strong writing skills.",
                       category: .humanities,
                       requirements: ["Open to all students", "Essay submission required"]),
            
            Scholarship(name: "Storwell Foster Children Bursary Program",
                       amount: 2000,
                       deadline: storwellDate,
                       description: "For current or former foster children pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Ages 16-24", "Current/former foster child"]),
            
            Scholarship(name: "Northwestel Northern Futures Scholarship",
                       amount: 4000,
                       deadline: northwestelDate,
                       description: "For students in Northern Canada pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Northern Canadian resident", "Minimum 70% average"]),
            
            Scholarship(name: "SEIU Healthcare Scholarship",
                       amount: 1800,
                       deadline: seiuDate,
                       description: "For SEIU Healthcare members and their families.",
                       category: .general,
                       requirements: ["SEIU Healthcare member or family member"]),
            
            Scholarship(name: "BC First Nations Student Scholarship",
                       amount: 2000,
                       deadline: bcFirstNationsDate,
                       description: "For First Nations students in British Columbia.",
                       category: .general,
                       requirements: ["First Nations status", "BC resident"]),
            
            Scholarship(name: "Women's Right to Vote Centennial Scholarship",
                       amount: 1000,
                       deadline: womensVoteDate,
                       description: "Commemorating 100 years of women's suffrage in Newfoundland & Labrador.",
                       category: .general,
                       requirements: ["Newfoundland & Labrador resident", "Female student"]),
            
            Scholarship(name: "CWB Welding Scholarships",
                       amount: 3000,
                       deadline: cwbDate,
                       description: "For students pursuing welding or related trades.",
                       category: .stem,
                       requirements: ["Canadian citizen or permanent resident", "Enrolled in welding program"]),
            
            Scholarship(name: "Hensall Co-op Bright Futures Scholarship",
                       amount: 2500,
                       deadline: hensallDate,
                       description: "For students pursuing agriculture-related studies.",
                       category: .stem,
                       requirements: ["Canadian citizen or permanent resident", "Agriculture program enrollment"]),
            
            Scholarship(name: "Black Girl Hockey Club Scholarship",
                       amount: 3000,
                       deadline: blackGirlHockeyDate,
                       description: "For Black female hockey players pursuing higher education.",
                       category: .general,
                       requirements: ["Black female", "Hockey player", "Minimum 2.5 GPA"]),
            
            Scholarship(name: "CN Pensioners' Association Scholarship",
                       amount: 1500,
                       deadline: cnPensionersDate,
                       description: "For children and grandchildren of CN pensioners.",
                       category: .general,
                       requirements: ["CN pensioner family member", "Minimum 75% average"]),
            
            Scholarship(name: "Osuuspankki Finnish Credit Union Scholarship",
                       amount: 5000,
                       deadline: osuuspankkiDate,
                       description: "For students of Finnish descent in Canada.",
                       category: .general,
                       requirements: ["Finnish heritage", "Canadian citizen or permanent resident"]),
            
            Scholarship(name: "belairdirect Scholarship",
                       amount: 1000,
                       deadline: belairdirectDate,
                       description: "For students who demonstrate leadership and community involvement.",
                       category: .general,
                       requirements: ["Canadian resident", "Full-time student"]),
            
            Scholarship(name: "Bill Mason Memorial Scholarship",
                       amount: 2000,
                       deadline: billMasonDate,
                       description: "For students passionate about outdoor education and environmental conservation.",
                       category: .stem,
                       requirements: ["Canadian citizen or permanent resident", "Environmental studies major"]),
            
            Scholarship(name: "Horatio Alger Indigenous Achievement Scholarships",
                       amount: 2500,
                       deadline: horatioAlgerDate,
                       description: "For Indigenous students who have overcome adversity.",
                       category: .general,
                       requirements: ["Status/Non-status/Inuit/Métis", "Demonstrated financial need"]),
            
            Scholarship(name: "Fulbright Canada Student Awards",
                       amount: 25000,
                       deadline: fulbrightDate,
                       description: "For Canadian students pursuing graduate studies in the United States.",
                       category: .general,
                       requirements: ["Canadian citizen", "Bachelor's degree required"]),
            
            Scholarship(name: "NSHSS Future Educators Scholarship",
                       amount: 1000,
                       deadline: nshssEducatorsDate,
                       description: "For students pursuing a career in education.",
                       category: .general,
                       requirements: ["Education major", "Minimum 3.0 GPA"]),
            
            Scholarship(name: "CNIB Foundation Post-Secondary Scholarships",
                       amount: 8000,
                       deadline: cnibDate,
                       description: "For students who are legally blind.",
                       category: .general,
                       requirements: ["Legally blind", "Canadian citizen or permanent resident"]),
            
            Scholarship(name: "Friends of Canadian Simmental Foundation Scholarships",
                       amount: 3000,
                       deadline: simmentalDate,
                       description: "For students involved in the beef cattle industry.",
                       category: .stem,
                       requirements: ["Canadian citizen or permanent resident", "Agriculture/Animal Science major"]),
            
            Scholarship(name: "Castle Trade Scholarship",
                       amount: 2500,
                       deadline: castleTradeDate,
                       description: "For students pursuing skilled trades education.",
                       category: .stem,
                       requirements: ["Enrolled in a trade program", "Canadian resident"]),
            
            Scholarship(name: "MROO Scholarship Program",
                       amount: 3000,
                       deadline: mrooDate,
                       description: "For children and grandchildren of MROO members.",
                       category: .general,
                       requirements: ["MROO member family", "Ontario resident"]),
            
            Scholarship(name: "NSHSS Hometown Hero Scholarships",
                       amount: 1000,
                       deadline: nshssHeroDate,
                       description: "For students who have made a difference in their communities.",
                       category: .general,
                       requirements: ["Minimum 3.0 GPA", "Community service involvement"]),
            
            Scholarship(name: "Strike Group LGBTQ2S+ Scholarship",
                       amount: 2000,
                       deadline: strikeLgbtqDate,
                       description: "For LGBTQ2S+ students pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Self-identified LGBTQ2S+", "Canadian citizen or permanent resident"]),
            
            Scholarship(name: "Strike Group Indigenous Scholarship",
                       amount: 2000,
                       deadline: strikeIndigenousDate,
                       description: "For Indigenous students pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Status/Non-status/Inuit/Métis"]),
            
            Scholarship(name: "Me & Lau Family Foundation Scholarships",
                       amount: 1200,
                       deadline: meLauDate,
                       description: "For students who demonstrate academic excellence and financial need.",
                       category: .general,
                       requirements: ["Minimum 80% average", "Canadian citizen or permanent resident"]),
            
            Scholarship(name: "MIHR Mining Industry Scholarships",
                       amount: 2500,
                       deadline: mihrDate,
                       description: "For students pursuing mining-related studies.",
                       category: .stem,
                       requirements: ["Mining/Geology/Engineering major", "Canadian resident"]),
            
            Scholarship(name: "The Citizens Foundation Canada Youth Bursary",
                       amount: 3000,
                       deadline: citizensFoundationDate,
                       description: "For students who have demonstrated leadership and community service.",
                       category: .general,
                       requirements: ["Canadian citizen or permanent resident", "Minimum 75% average"]),
            
            Scholarship(name: "Curling Canada Scholarship",
                       amount: 2500,
                       deadline: curlingDate,
                       description: "For competitive curlers pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Competitive curler", "Canadian citizen or permanent resident"]),
            
            Scholarship(name: "PSAC Scholarship Program",
                       amount: 4000,
                       deadline: psacDate,
                       description: "For PSAC members and their families.",
                       category: .general,
                       requirements: ["PSAC member or family member"]),
            
            Scholarship(name: "Bill 7 Award",
                       amount: 4500,
                       deadline: bill7Date,
                       description: "For LGBTQ2S+ students in Ontario facing financial barriers.",
                       category: .general,
                       requirements: ["Ontario resident", "LGBTQ2S+ identified", "Financial need"]),
            
            Scholarship(name: "Brian Maxwell Memorial Scholarship",
                       amount: 5000,
                       deadline: brianMaxwellDate,
                       description: "For student-athletes who demonstrate leadership and sportsmanship.",
                       category: .general,
                       requirements: ["Competitive athlete", "Minimum 75% average"]),
            
            Scholarship(name: "Unifor Scholarships",
                       amount: 2000,
                       deadline: uniforDate,
                       description: "For Unifor members and their families.",
                       category: .general,
                       requirements: ["Unifor member or family member"]),
            
            Scholarship(name: "CCOHS Chad Bradley Scholarship",
                       amount: 3000,
                       deadline: ccohsDate,
                       description: "For students pursuing occupational health and safety studies.",
                       category: .stem,
                       requirements: ["Occupational health/safety major", "Canadian resident"]),
            
            Scholarship(name: "Metal Supermarkets Trade School Scholarship",
                       amount: 2500,
                       deadline: metalSupermarketsDate,
                       description: "For students enrolled in trade school programs.",
                       category: .stem,
                       requirements: ["Enrolled in trade program", "Canadian resident"]),
            
            Scholarship(name: "Spin Master Future of Play Scholarship",
                       amount: 12500,
                       deadline: spinMasterDate,
                       description: "For students who demonstrate creativity and innovation.",
                       category: .general,
                       requirements: ["Canadian citizen or permanent resident", "Portfolio submission required"]),
            
            Scholarship(name: "Mike Puhallo Memorial Scholarship",
                       amount: 500,
                       deadline: mikePuhalloDate,
                       description: "For students involved in cowboy culture and heritage.",
                       category: .general,
                       requirements: ["Involvement in cowboy culture", "BC resident"]),
            
            Scholarship(name: "Modern Métis Woman Scholarship",
                       amount: 1000,
                       deadline: modernMetisDate,
                       description: "For Métis women pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Métis woman", "Canadian citizen or permanent resident"]),
            
            Scholarship(name: "Canada Company Scholarship",
                       amount: 5000,
                       deadline: Date(), // Varies
                       description: "For children of Canadian Armed Forces members.",
                       category: .general,
                       requirements: ["Parent/guardian in Canadian Armed Forces"]),
            
            Scholarship(name: "UFCW Canada BDM Scholarships",
                       amount: 1000,
                       deadline: ufcwDate,
                       description: "For UFCW Canada members and their families.",
                       category: .general,
                       requirements: ["UFCW Canada member or family member"]),
            
            Scholarship(name: "CAWIC Bursary",
                       amount: 2000,
                       deadline: cawicDate,
                       description: "For women pursuing careers in construction-related fields.",
                       category: .stem,
                       requirements: ["Female student", "Construction-related program"]),
            
            Scholarship(name: "BC First Nations Forestry Council Scholarship",
                       amount: 2500,
                       deadline: Date(), // Varies
                       description: "For Indigenous students pursuing forestry-related studies.",
                       category: .stem,
                       requirements: ["First Nations status", "BC resident", "Forestry program enrollment"]),
            
            Scholarship(name: "Outstanding Young Farmers Memorial Scholarship",
                       amount: 1000,
                       deadline: youngFarmersDate,
                       description: "For students pursuing agricultural studies.",
                       category: .stem,
                       requirements: ["Agriculture program enrollment", "Canadian resident"]),
            
            Scholarship(name: "WHSC Student Scholarship Contest",
                       amount: 6000,
                       deadline: whscDate,
                       description: "For students who demonstrate knowledge of workplace health and safety.",
                       category: .stem,
                       requirements: ["Essay submission required", "Canadian resident"]),
            
            Scholarship(name: "Support Our Troops Scholarship",
                       amount: 5000,
                       deadline: supportTroopsDate,
                       description: "For children of Canadian Armed Forces members.",
                       category: .general,
                       requirements: ["Parent/guardian in Canadian Armed Forces"]),
            
            Scholarship(name: "Ethel Boyce Achievement Award",
                       amount: 1000,
                       deadline: ethelBoyceDate,
                       description: "For female softball players pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Competitive softball player", "Female student"]),
            
            Scholarship(name: "Castagra Roofing Scholarship",
                       amount: 1000,
                       deadline: castagraDate,
                       description: "For students pursuing construction or engineering studies.",
                       category: .stem,
                       requirements: ["Construction/Engineering major", "Canadian resident"]),
            
            Scholarship(name: "Opterus Valerie Ann Arts Award",
                       amount: 10000,
                       deadline: opterusArtsDate,
                       description: "For students pursuing fine arts or performing arts.",
                       category: .general,
                       requirements: ["Fine/Performing Arts major", "Portfolio required"]),
            
            Scholarship(name: "Opterus Helen Rose STEM Award",
                       amount: 10000,
                       deadline: opterusStemDate,
                       description: "For women pursuing STEM education.",
                       category: .stem,
                       requirements: ["Female student", "STEM major"]),
            
            Scholarship(name: "Allied Van Lines Scholarship",
                       amount: 1000,
                       deadline: alliedVanLinesDate,
                       description: "For students pursuing logistics or supply chain management.",
                       category: .general,
                       requirements: ["Logistics/Supply Chain major", "Canadian resident"]),
            
            Scholarship(name: "BluEarth Renewables Scholarship",
                       amount: 3000,
                       deadline: bluEarthDate,
                       description: "For students pursuing renewable energy or environmental studies.",
                       category: .stem,
                       requirements: ["Renewable Energy/Environmental Studies major"]),
            
            Scholarship(name: "ResourceAbilities Alice & Roy Bruce Memorial Scholarship",
                       amount: 500,
                       deadline: resourceAbilitiesDate,
                       description: "For students with disabilities in PEI.",
                       category: .general,
                       requirements: ["PEI resident", "Documented disability"]),
            
            Scholarship(name: "PEI Foundation for People with Disabilities Awards",
                       amount: 500,
                       deadline: peiFoundationDate,
                       description: "For PEI students with disabilities.",
                       category: .general,
                       requirements: ["PEI resident", "Documented disability"]),
            
            Scholarship(name: "BigSun Scholarship",
                       amount: 500,
                       deadline: bigSunDate,
                       description: "For student-athletes pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Competitive athlete", "Canadian resident"]),
            
            Scholarship(name: "SGI Graduate Research Grant",
                       amount: 5000,
                       deadline: sgiResearchDate,
                       description: "For graduate students in transportation safety research.",
                       category: .stem,
                       requirements: ["Graduate student", "Transportation safety research"]),
            
            Scholarship(name: "SGI Stan Hamilton Scholarship",
                       amount: 2500,
                       deadline: sgiHamiltonDate,
                       description: "For students pursuing trades education in Saskatchewan.",
                       category: .stem,
                       requirements: ["Saskatchewan resident", "Trades program enrollment"]),
            
            Scholarship(name: "AbbVie IBD Scholarship",
                       amount: 5000,
                       deadline: abbVieDate,
                       description: "For students living with Crohn's disease or ulcerative colitis.",
                       category: .general,
                       requirements: ["Diagnosed with IBD", "Canadian resident"]),
            
            Scholarship(name: "FWIO Provincial Scholarship",
                       amount: 1000,
                       deadline: fwioDate,
                       description: "For female students in rural Ontario.",
                       category: .general,
                       requirements: ["Female student", "Rural Ontario resident"]),
            
            Scholarship(name: "PEOPEO Sisterhood Education Grant",
                       amount: 4000,
                       deadline: Date(), // Varies
                       description: "For women pursuing education later in life.",
                       category: .general,
                       requirements: ["Female student", "25+ years old"]),
            
            Scholarship(name: "Valour Canada History Scholarship",
                       amount: 1500,
                       deadline: valourCanadaDate,
                       description: "For students with an interest in Canadian military history.",
                       category: .humanities,
                       requirements: ["History major preferred", "Canadian resident"]),
            
            Scholarship(name: "Terry Fox Humanitarian Award",
                       amount: 28000,
                       deadline: terryFoxDate,
                       description: "For students who demonstrate humanitarian service and courage.",
                       category: .general,
                       requirements: ["Canadian citizen or permanent resident", "Humanitarian service"]),
            
            Scholarship(name: "North American Van Lines Logistics Scholarship",
                       amount: 1000,
                       deadline: northAmericanDate,
                       description: "For students pursuing logistics or supply chain management.",
                       category: .general,
                       requirements: ["Logistics/Supply Chain major", "Canadian resident"]),
            
            Scholarship(name: "Disability Credit Canada Scholarship",
                       amount: 1000,
                       deadline: disabilityCreditDate,
                       description: "For students with disabilities.",
                       category: .general,
                       requirements: ["Documented disability", "Canadian resident"]),
            
            Scholarship(name: "moneyGenius Scholarship Canada",
                       amount: 2000,
                       deadline: moneyGeniusDate,
                       description: "For students interested in personal finance.",
                       category: .general,
                       requirements: ["Canadian resident", "Essay submission required"]),
            
            Scholarship(name: "ACUFC French Second Language Bursary",
                       amount: 3000,
                       deadline: Date(), // Varies
                       description: "For students pursuing studies in French as a second language.",
                       category: .humanities,
                       requirements: ["FSL program enrollment", "Canadian citizen or permanent resident"]),
            
            Scholarship(name: "McCall MacBain Scholarships",
                       amount: 10000,
                       deadline: mccallMacBainDate,
                       description: "For exceptional students entering graduate studies.",
                       category: .general,
                       requirements: ["Bachelor's degree required", "Leadership potential"]),
            
            Scholarship(name: "Mon Sheong Golden Jubilee Scholarship",
                       amount: 1000,
                       deadline: monSheongDate,
                       description: "For students of Chinese heritage pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Chinese heritage", "Canadian citizen or permanent resident"]),
            
            Scholarship(name: "GoTranscript Academic Scholarship",
                       amount: 5000,
                       deadline: Date(), // Varies
                       description: "For students pursuing higher education.",
                       category: .general,
                       requirements: ["Open to all students", "Essay submission required"]),
            
            Scholarship(name: "GlobalScholarships.com Scholarship for International Students",
                       amount: 3000,
                       deadline: dateFormatter.date(from: "February 1, 2026")!,
                       description: "For international students studying abroad.",
                       category: .general,
                       requirements: ["International student status", "Studying outside home country"]),
            
            Scholarship(name: "George F. Jones Scholarship (Canadian Rugby Foundation)",
                       amount: 0, // Varies
                       deadline: rugbyFoundationDate,
                       description: "For students enrolled in Canadian post-secondary programs who are involved in rugby and community development.",
                       category: .general,
                       requirements: ["Enrolled in Canadian college/university", "Involvement in rugby community", "Academic achievements", "Community service"]),
            
            Scholarship(name: "Thomas Family Scholarship (Canadian Rugby Foundation)",
                       amount: 0, // Varies
                       deadline: thomasFamilyDate,
                       description: "For young rugby players aged 17-21 enrolled in Canadian post-secondary education.",
                       category: .general,
                       requirements: ["Aged 17-21", "Currently playing rugby in Canada", "Enrolled in Canadian college/university", "Academic achievement"]),
            
            Scholarship(name: "AIA Canada High Fives for Kids Scholarship",
                       amount: 1000,
                       deadline: aiaCanadaDate,
                       description: "For children of employees in AIA Canada member companies pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Parent employed by AIA Canada member", "Enrolled in post-secondary program", "Academic achievement", "Extracurricular involvement"]),
            
            Scholarship(name: "Leliefontein Memorial Bursary (Royal Canadian Dragoons)",
                       amount: 500,
                       deadline: leliefonteinDate,
                       description: "For descendants of Royal Canadian Dragoons members pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Descendant of Royal Canadian Dragoons member", "Accepted to post-secondary education", "Community service", "Academic achievement"]),
            
            Scholarship(name: "MJT Herrendorf Family Foundation Scholarships",
                       amount: 1000,
                       deadline: mjtDate,
                       description: "For MJT members entering 1st or 2nd year of post-secondary education in Canada.",
                       category: .general,
                       requirements: ["MJT member", "Canadian resident", "Entering 1st/2nd year post-secondary", "Financial need"]),
            
            Scholarship(name: "International AES Engineering Scholarship",
                       amount: 500,
                       deadline: aesEngineeringDate,
                       description: "Open to high school seniors and post-secondary students. No engineering requirement.",
                       category: .general,
                       requirements: ["High school senior or current post-secondary student", "Essay required"]),
            
            Scholarship(name: "Loran Award",
                       amount: 3000,
                       deadline: loranDate,
                       description: "For students entering university for the first time with strong leadership potential.",
                       category: .general,
                       requirements: ["Entering 1st year university in 2025", "85%+ average", "Canadian citizen/PR", "Leadership and community service"]),
            
            Scholarship(name: "International Pretty Photoshop Actions Scholarship Program",
                       amount: 500,
                       deadline: photoshopDate,
                       description: "For high school seniors in US/Canada to showcase their Photoshop skills.",
                       category: .general,
                       requirements: ["High school senior in US/Canada", "800+ word Photoshop tutorial with screenshots"]),
            
            Scholarship(name: "AmericanMuscle's Student Scholarship Program",
                       amount: 2500,
                       deadline: americanMuscleDate,
                       description: "For students in automotive engineering programs or planning to attend.",
                       category: .stem,
                       requirements: ["Enrolled in automotive program or accepted to one", "Essay required"]),
            
            Scholarship(name: "Eaton - Indigenous Clean Energy Scholarship",
                       amount: 5000,
                       deadline: eatonDate,
                       description: "For Indigenous students pursuing careers in electrical work and clean energy.",
                       category: .stem,
                       requirements: ["Indigenous student", "Pursuing electrical trade/engineering", "Canadian resident"]),
            
            Scholarship(name: "JCCF Photography / Digital Art Contest",
                       amount: 2000,
                       deadline: jccfDate,
                       description: "Creative contest on the theme of freedom in democracy through photography and digital art.",
                       category: .general,
                       requirements: ["Canadian citizen/PR", "Original photography/digital art submission", "Theme: freedom in democracy"]),
            
            Scholarship(name: "TD Scholarships for Community Leadership",
                       amount: 17500,
                       deadline: tdDate,
                       description: "For high school seniors who have demonstrated outstanding community leadership.",
                       category: .general,
                       requirements: ["Canadian citizen/PR", "Final year of high school", "75%+ average", "Community leadership"]),
            
            Scholarship(name: "Driver Education Initiative Award",
                       amount: 500,
                       deadline: driverEducationDate,
                       description: "Annual scholarship for students interested in driver education and safety.",
                       category: .general,
                       requirements: ["Enrolled in high school/university/college", "Essay submission required"]),
            
            Scholarship(name: "Smooth Movers Scholarship",
                       amount: 1000,
                       deadline: smoothMoversDate,
                       description: "For students demonstrating academic excellence and community involvement.",
                       category: .general,
                       requirements: ["Enrolled in high school/college/university", "Essay and video submission required"]),
            
            Scholarship(name: "Building Brighter Futures: Bursaries and Scholarships - Indspire",
                       amount: 0, // Varies
                       deadline: indspireDate,
                       description: "For Indigenous students pursuing post-secondary education in various fields.",
                       category: .general,
                       requirements: ["Canadian Indigenous person", "Pursuing post-secondary education"]),
            
            Scholarship(name: "Soroptimist Live Your Dream Awards",
                       amount: 1000,
                       deadline: soroptimistDate,
                       description: "For women who are the primary financial supporters of their families.",
                       category: .general,
                       requirements: ["Female student", "Primary financial supporter", "Enrolled in education program"]),
            
            Scholarship(name: "Kidney Foundation of Canada Scholarships",
                       amount: 1000,
                       deadline: kidneyFoundationDate,
                       description: "For volunteers and staff of the Kidney Foundation pursuing further education.",
                       category: .general,
                       requirements: ["Canadian resident", "Volunteer/staff of Kidney Foundation", "Personal statement required"]),
            
            Scholarship(name: "Odenza Marketing Group Scholarship",
                       amount: 500,
                       deadline: odenzaDate,
                       description: "For students pursuing careers in marketing and business.",
                       category: .general,
                       requirements: ["Aged 16-25", "US/Canadian citizen", "2.5+ GPA", "1+ year of studies remaining"]),
            
            Scholarship(name: "Nutrien Indigenous Youth Financial Management Awards",
                       amount: 1000,
                       deadline: nutrienDate,
                       description: "For Indigenous students pursuing education in finance and business.",
                       category: .general,
                       requirements: ["Indigenous student", "Grade 11/12 or post-secondary", "Pursuing finance/management/commerce"]),
            
            Scholarship(name: "Captain Judy Cameron Scholarship for Aspiring Women in Aviation",
                       amount: 5000,
                       deadline: judyCameronDate,
                       description: "For women pursuing careers as commercial pilots or aircraft maintenance engineers.",
                       category: .stem,
                       requirements: ["Female student", "Canadian citizen", "Enrolled in aviation program"]),
            
            Scholarship(name: "Arthur Paulin Automotive Aftermarket Scholarship Award",
                       amount: 700,
                       deadline: arthurPaulinDate,
                       description: "For students in automotive aftermarket industry programs.",
                       category: .stem,
                       requirements: ["Enrolled in automotive aftermarket program", "Canadian student"]),
            
            Scholarship(name: "Student Achievement Awards - OSSTF/FEESO",
                       amount: 1000,
                       deadline: osstfDate,
                       description: "Writing and creative arts competition for Ontario secondary students.",
                       category: .general,
                       requirements: ["Ontario secondary student", "Writing/art submission", "Theme-based"]),
            
            Scholarship(name: "Heer Law Entrepreneurship Scholarship",
                       amount: 2000,
                       deadline: heerLawDate,
                       description: "For students with entrepreneurial ambitions and a business plan.",
                       category: .general,
                       requirements: ["University/college student or incoming student", "Business plan submission required", "Intellectual property strategy required"]),
            
            Scholarship(name: "DEWALT Trades Scholarship",
                       amount: 5000,
                       deadline: dewaltDate,
                       description: "For students pursuing careers in skilled trades and technology.",
                       category: .stem,
                       requirements: ["High school senior", "Enrolling in trade/technical program", "2.0+ GPA"]),
            
            Scholarship(name: "Gulab Oils Visual Arts Scholarship Program",
                       amount: 5000,
                       deadline: gulabOilsDate,
                       description: "For students pursuing visual arts education with financial need.",
                       category: .general,
                       requirements: ["Accepted to Visual Arts program", "3.9+ GPA", "6+ months industry experience"]),
            
            Scholarship(name: "Dick Martin Scholarship Award",
                       amount: 3000,
                       deadline: dickMartinDate,
                       description: "For students in occupational health and safety programs.",
                       category: .stem,
                       requirements: ["Enrolled in OHS program", "Canadian college/university", "Essay submission required"]),
            
            Scholarship(name: "Ottawa Community Housing Education Bursary",
                       amount: 1000,
                       deadline: Date(), // Ongoing
                       description: "For tenants of Ottawa Community Housing pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Ottawa Community Housing tenant", "Enrolled in Canadian post-secondary"]),
            
            Scholarship(name: "International Burger King Scholarships",
                       amount: 1000,
                       deadline: burgerKingDate,
                       description: "For high school seniors in US, Canada, Puerto Rico, Guam planning to attend college/university.",
                       category: .general,
                       requirements: ["High school senior", "Planning to attend college/university", "Academic record", "Community involvement", "Financial need"]),
            
            Scholarship(name: "Launchpad Scholarship by Tundra Technical",
                       amount: 1000,
                       deadline: launchpadDate,
                       description: "For women and non-binary students in Grade 12 planning to attend STEM programs.",
                       category: .stem,
                       requirements: ["Female or non-binary", "Grade 12 student", "75%+ average", "STEM program intent", "Essay/project plan required"]),
            
            Scholarship(name: "ORBA College Civil Engineering Technology Scholarship",
                       amount: 2000,
                       deadline: orbaCollegeDate,
                       description: "For Ontario high school graduates entering Civil Technology programs.",
                       category: .stem,
                       requirements: ["Ontario high school graduate", "Entering 1st year Civil Technology", "Community involvement", "Work experience"]),
            
            Scholarship(name: "ORBA University Civil Engineering Technology Scholarship",
                       amount: 2000,
                       deadline: orbaUniversityDate,
                       description: "For Ontario high school students entering Civil Engineering programs.",
                       category: .stem,
                       requirements: ["Ontario high school student", "Entering 1st year Civil Engineering", "Community service", "Academic achievement"]),
            
            Scholarship(name: "International Automotive Women's Alliance Foundation Scholarships",
                       amount: 5000,
                       deadline: automotiveWomenDate,
                       description: "For women pursuing careers in automotive and mobility industries.",
                       category: .stem,
                       requirements: ["Female student", "3.0+ GPA", "Enrolled in post-secondary", "North American citizenship"]),
            
            Scholarship(name: "National Essay Contest (French for the Future)",
                       amount: 1000,
                       deadline: frenchEssayDate,
                       description: "French essay contest for Canadian students in grades 10-12.",
                       category: .humanities,
                       requirements: ["Canadian resident", "Grades 10-12", "French essay submission"]),
            
            Scholarship(name: "Canadian Angus Foundation Legacy Scholarship",
                       amount: 5000,
                       deadline: angusDate,
                       description: "For members of Canadian Junior Angus Association pursuing post-secondary education.",
                       category: .stem,
                       requirements: ["CJA member", "Final year of high school", "Academic achievement", "Leadership"]),
            
            Scholarship(name: "John Evans Engineering Entrance Award",
                       amount: 5000,
                       deadline: johnEvansDate,
                       description: "For women entering Canadian Engineering programs with leadership potential.",
                       category: .stem,
                       requirements: ["Female student", "Canadian citizen/PR", "High school graduate", "Leadership potential", "Presentation required"]),
            
            Scholarship(name: "Orange Scholars Scholarship Program",
                       amount: 2500,
                       deadline: orangeScholarsDate,
                       description: "For dependents of Home Depot associates pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Dependent of Home Depot associate", "High school senior", "Financial need", "Community involvement"]),
            
            Scholarship(name: "Children's Aid Foundation Scholarships",
                       amount: 5000,
                       deadline: childrensAidDate,
                       description: "For current or former youth in care pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Current/former youth in care", "Under 30 years old", "Registered in post-secondary"]),
            
            Scholarship(name: "Don Bossi Leadership & Innovation Scholarship",
                       amount: 5000,
                       deadline: donBossiDate,
                       description: "For FIRST Robotics participants pursuing innovation and leadership in STEM.",
                       category: .stem,
                       requirements: ["Canadian high school student", "FIRST Robotics participant", "Pursuing innovation/entrepreneurship"]),
            
            Scholarship(name: "PPAO Memorial Scholarship",
                       amount: 3000,
                       deadline: ppaoDate,
                       description: "For family members of PPAO members pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Family of PPAO member", "Aged 16-25", "Community service", "Academic achievement"]),
            
            Scholarship(name: "Canadian Women in STEM Award",
                       amount: 10000,
                       deadline: womenStemDate,
                       description: "For young women in FIRST Robotics pursuing STEM education.",
                       category: .stem,
                       requirements: ["Female student", "FIRST Robotics participant", "Enrolled in STEM program"]),
            
            Scholarship(name: "Children's Aid Foundation Bursary",
                       amount: 2000,
                       deadline: Date(), // Ongoing
                       description: "For current or former youth in care with financial need for education.",
                       category: .general,
                       requirements: ["Current/former youth in care", "Under 30 years old", "Financial need"]),
            
            Scholarship(name: "Kin Canada Bursaries",
                       amount: 1000,
                       deadline: kinCanadaDate,
                       description: "For Canadian students demonstrating community involvement and financial need.",
                       category: .general,
                       requirements: ["Canadian citizen/landed immigrant", "High school graduate or current post-secondary student", "Community/school involvement", "Knowledge of Kin Canada"]),
            
            Scholarship(name: "W.H. 'Howie' McClennan Scholarship Fund",
                       amount: 2500,
                       deadline: mcclennanDate,
                       description: "For children of IAFF members killed in the line of duty.",
                       category: .general,
                       requirements: ["Child of IAFF member killed in line of duty", "Planning to attend post-secondary", "Financial need", "Academic achievement"]),
            
            Scholarship(name: "SME Education Foundation Scholarships",
                       amount: 20000,
                       deadline: smeDate,
                       description: "For students pursuing degrees in manufacturing-related technical fields.",
                       category: .stem,
                       requirements: ["US/Canadian citizen/PR", "2.0+ GPA", "Pursuing manufacturing-related degree"]),
            
            Scholarship(name: "Union of Safety and Justice Employees Scholarships",
                       amount: 2500,
                       deadline: safetyJusticeDate,
                       description: "For union members and their families pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Union member/family", "Pursuing post-secondary", "Volunteer/extracurricular involvement", "Essay/infographic submission"]),
            
            Scholarship(name: "Kay Sansom Scholarships",
                       amount: 1000,
                       deadline: kaySansomDate,
                       description: "For Ontario students pursuing careers related to developmental disabilities.",
                       category: .general,
                       requirements: ["Ontario student", "Interest in developmental disabilities", "Enrolled in related program"]),
            
            Scholarship(name: "RBC Future Launch Scholarship for Indigenous Youth",
                       amount: 10000,
                       deadline: rbcFutureDate,
                       description: "For Indigenous youth entering post-secondary education.",
                       category: .general,
                       requirements: ["Indigenous (Status/Non-Status/Métis/Inuit)", "Canadian citizen/PR", "Aged 17-29", "Grade 12 student"]),
            
            Scholarship(name: "Ontario Minor Hockey Association (OMHA) Bursary Program",
                       amount: 5000,
                       deadline: omhaDate,
                       description: "For long-time OMHA players pursuing post-secondary education in Ontario.",
                       category: .general,
                       requirements: ["Under 20 years old", "5+ years in OMHA", "Academic excellence", "Community involvement"]),
            
            Scholarship(name: "Ted Rogers Scholarship Fund",
                       amount: 2500,
                       deadline: tedRogersDate,
                       description: "For former youth in care pursuing their first post-secondary program.",
                       category: .general,
                       requirements: ["Aged 24 or under", "12+ months in government care", "First post-secondary program", "Financial need"]),
            
            Scholarship(name: "Silver Spring Farm Scholarship Award",
                       amount: 2500,
                       deadline: silverSpringDate,
                       description: "For students in social sciences or human services in Eastern Ontario.",
                       category: .general,
                       requirements: ["Enrolled in social sciences/human services", "Eastern Ontario institution", "Volunteer experience"]),
            
            Scholarship(name: "Millie Brother Scholarship for Hearing Children of Deaf Adults",
                       amount: 0, // Varies
                       deadline: millieBrotherDate,
                       description: "For hearing children of deaf adults pursuing higher education.",
                       category: .general,
                       requirements: ["Hearing child of deaf adults", "Enrolled in higher education"]),
            
            Scholarship(name: "Optimist International Essay Contest",
                       amount: 2500,
                       deadline: optimistDate,
                       description: "Essay contest for students under 19 in US, Canada, and Caribbean.",
                       category: .humanities,
                       requirements: ["Under 19 years old", "Resident of US/Canada/Caribbean", "Essay submission"]),
            
            Scholarship(name: "Tall Clubs International Academic Scholarships",
                       amount: 1000,
                       deadline: tallClubsDate,
                       description: "For exceptionally tall students pursuing higher education.",
                       category: .general,
                       requirements: ["Women: 5'10\" (178cm)", "Men: 6'2\" (188cm)", "Under 21 years old", "Entering 1st year post-secondary"]),
            
            Scholarship(name: "RE/MAX Quest for Excellence Scholarship",
                       amount: 1000,
                       deadline: remaxDate,
                       description: "For Canadian high school students demonstrating academic excellence.",
                       category: .general,
                       requirements: ["Canadian high school student", "Essay submission required"]),
            
            Scholarship(name: "Lionel Chemistry Scholarship",
                       amount: 4000,
                       deadline: lionelDate,
                       description: "For students pursuing chemistry-related studies at Canadian institutions.",
                       category: .stem,
                       requirements: ["Canadian citizen/PR", "Entering BSc program", "Chemistry-related field", "Financial need"]),
            
            Scholarship(name: "Allan Simpson Educational Fund Awards",
                       amount: 0, // Varies
                       deadline: allanSimpsonDate,
                       description: "Support for students who have lost both parents.",
                       category: .general,
                       requirements: ["Orphan (both parents deceased)", "Enrolled in post-secondary"]),
            
            Scholarship(name: "Boilermaker Scholarships",
                       amount: 5000,
                       deadline: boilermakerDate,
                       description: "For dependents of Boilermaker union members.",
                       category: .stem,
                       requirements: ["Dependent of Boilermaker member", "High school senior", "Entering post-secondary", "Essay required"]),
            
            Scholarship(name: "James R. Hoffa Memorial Scholarship Fund",
                       amount: 2500,
                       deadline: hoffaDate,
                       description: "For children of Teamster union members.",
                       category: .stem,
                       requirements: ["Child of Teamster member", "High school senior", "Community service", "Letters of recommendation"]),
            
            Scholarship(name: "Diabetes Hope Scholarship",
                       amount: 3000,
                       deadline: diabetesHopeDate,
                       description: "For Ontario students with Type 1 Diabetes pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Type 1 Diabetes diagnosis", "Ontario resident", "High school senior", "Canadian citizen/PR"]),
            
            Scholarship(name: "COPA Neil J Armstrong Ab-Initio Scholarship",
                       amount: 14000,
                       deadline: copaDate,
                       description: "For young Canadians pursuing flight training.",
                       category: .stem,
                       requirements: ["Aged 16-21", "Canadian citizen/PR", "Interest in aviation", "Financial need"]),
            
            Scholarship(name: "St. John Ambulance Scholarships",
                       amount: 0, // Varies
                       deadline: stJohnDate,
                       description: "For active St. John Ambulance volunteers pursuing further education.",
                       category: .general,
                       requirements: ["Active St. John Ambulance volunteer", "Academic achievement", "Financial need"]),
            
            Scholarship(name: "UCU Scholarships",
                       amount: 3000,
                       deadline: ucuDate,
                       description: "For members of Ukrainian Credit Union pursuing post-secondary education.",
                       category: .general,
                       requirements: ["UCU member for 2+ years", "Ontario resident", "Enrolled in post-secondary"]),
            
            Scholarship(name: "Girl Guides of Canada National Scholarships",
                       amount: 5000,
                       deadline: girlGuidesDate,
                       description: "For active Girl Guides members pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Registered GGC member", "Academic achievement", "Guiding participation"]),
            
            Scholarship(name: "Retail Education Scholarship Program",
                       amount: 5000,
                       deadline: retailDate,
                       description: "For students in retail-related programs currently working in retail.",
                       category: .general,
                       requirements: ["Enrolled in retail-related program", "Currently employed in retail"]),
            
            Scholarship(name: "Horatio Alger Association National Entrepreneurial Scholarships",
                       amount: 25000,
                       deadline: horatioAlgerDate,
                       description: "For Canadian students with entrepreneurial aspirations facing financial need.",
                       category: .general,
                       requirements: ["Canadian citizen", "Grade 11 student", "70%+ average", "Financial need", "Entrepreneurial interest"]),
            
            Scholarship(name: "Jamie Hubley Memorial Scholarship",
                       amount: 2000,
                       deadline: jamieHubleyDate,
                       description: "For Ottawa residents pursuing mental health education.",
                       category: .general,
                       requirements: ["Ottawa resident", "Mental health field of study", "Financial need"]),
            
            Scholarship(name: "Manulife Life Lessons Scholarship",
                       amount: 10000,
                       deadline: manulifeDate,
                       description: "For students who have lost a parent with little to no life insurance.",
                       category: .general,
                       requirements: ["Aged 17-24", "Canadian PR/citizen", "Parent passed without life insurance"]),
            
            Scholarship(name: "Kochhar & Co. Scholarship",
                       amount: 1000,
                       deadline: kochharDate,
                       description: "For students pursuing legal studies in Canada or US.",
                       category: .humanities,
                       requirements: ["2.5+ GPA", "Canadian/US resident", "Enrolled in post-secondary"]),
            
            Scholarship(name: "State of Kindness Scholarship Fund",
                       amount: 15000,
                       deadline: kindnessDate,
                       description: "For Ontario students who have overcome financial adversity.",
                       category: .general,
                       requirements: ["Ontario resident", "High school senior", "75%+ average", "Financial adversity"]),
            
            Scholarship(name: "BeArt-Presets Academic Scholarship Program",
                       amount: 2500,
                       deadline: beartDate,
                       description: "For students pursuing creative fields in higher education.",
                       category: .general,
                       requirements: ["High school senior or university student", "Essay submission required"]),
            
            Scholarship(name: "W2RO Scholarship Program",
                       amount: 2000,
                       deadline: w2roDate,
                       description: "For students pursuing careers in waste management and recycling.",
                       category: .stem,
                       requirements: ["Canadian resident", "Enrolled in related program", "Essay required"]),
            
            Scholarship(name: "G3 Grow Beyond Scholarship",
                       amount: 5000,
                       deadline: g3GrowBeyondDate,
                       description: "For students addressing global challenges through agricultural innovation.",
                       category: .stem,
                       requirements: ["Canadian high school senior", "Video submission required", "Community involvement"]),
            
            Scholarship(name: "Pretty Presets Lightroom Scholarship Program",
                       amount: 500,
                       deadline: prettyPresetsDate,
                       description: "For high school seniors interested in photography and digital editing.",
                       category: .arts,
                       requirements: ["High school senior", "US/Canada resident", "800+ word tutorial with screenshots"]),
            
            Scholarship(name: "CP Bursaries",
                       amount: 500,
                       deadline: Date(),
                       description: "For young Canadian women making a positive impact in their communities.",
                       category: .general,
                       requirements: ["Canadian female student", "Positive community impact", "Pay-it-forward commitment"]),
            
            Scholarship(name: "Global Lift Equipment Scholarship",
                       amount: 500,
                       deadline: globalLiftDate,
                       description: "For students in engineering programs with an interest in equipment technology.",
                       category: .stem,
                       requirements: ["2.5+ GPA", "US/Canadian resident", "Short story submission"]),
            
            Scholarship(name: "Lynch-Getty Award",
                       amount: 1000,
                       deadline: lynchGettyDate,
                       description: "For Ottawa-Carleton students promoting cross-cultural understanding.",
                       category: .humanities,
                       requirements: ["OCDSB Grade 12 student", "75%+ average", "Cross-cultural leadership"]),
            
            Scholarship(name: "Sean Jackson Scholarship",
                       amount: 10000,
                       deadline: seanJacksonDate,
                       description: "For Ontario students demonstrating outstanding community leadership.",
                       category: .general,
                       requirements: ["Ontario resident", "80%+ average", "Significant volunteer leadership"]),
            
            Scholarship(name: "AEA Educational Foundation Scholarship Program",
                       amount: 1000,
                       deadline: aeaDate,
                       description: "For students pursuing careers in aviation maintenance and avionics.",
                       category: .stem,
                       requirements: ["High school senior", "Accepted to aviation program", "Additional criteria vary"]),
            
            Scholarship(name: "Investintech - CAJ Journalism Scholarship",
                       amount: 1000,
                       deadline: investintechDate,
                       description: "For students pursuing data journalism in Canada.",
                       category: .humanities,
                       requirements: ["Canadian student", "Journalism/related field", "Data journalism interest"]),
            
            Scholarship(name: "GROWMARK Foundation Scholarship Program",
                       amount: 2000,
                       deadline: growmarkDate,
                       description: "For students in agriculture or business programs in Ontario.",
                       category: .stem,
                       requirements: ["High school senior", "Agriculture/business major", "Academic achievement"]),
            
            Scholarship(name: "Brandon Walli 'Phones Down, Eyes Up' Memorial Scholarship",
                       amount: 2500,
                       deadline: brandonWalliDate,
                       description: "For students pursuing arts or music education.",
                       category: .arts,
                       requirements: ["High school senior", "Arts/music program", "Volunteer experience"]),
            
            Scholarship(name: "Lime Connect Pathways Scholarship",
                       amount: 5000,
                       deadline: limeConnectDate,
                       description: "For high school seniors with disabilities pursuing higher education.",
                       category: .general,
                       requirements: ["Visible/invisible disability", "Accepted to 4-year program", "US/Canadian citizen"]),
            
            Scholarship(name: "Canadian Bates Scholarship",
                       amount: 2000,
                       deadline: canadianBatesDate,
                       description: "For children of BAC Local union members in Canada.",
                       category: .general,
                       requirements: ["Parent in BAC Local", "High school senior", "College enrollment"]),
            
            Scholarship(name: "Easter Seals Ontario Scholarship",
                       amount: 500,
                       deadline: easterSealsDate,
                       description: "For Ontario students with physical disabilities pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Permanent physical disability", "Ontario resident", "Post-secondary enrollment"]),
            
            Scholarship(name: "Actuonix Engineering Scholarship Program",
                       amount: 500,
                       deadline: actuonixDate,
                       description: "For engineering students with projects in robotics and automation.",
                       category: .stem,
                       requirements: ["Engineering student", "US/Canadian citizen", "Project submission"]),
            
            Scholarship(name: "Wendell King Memorial Bursary",
                       amount: 2500,
                       deadline: wendellKingDate,
                       description: "For students pursuing careers in the propane industry.",
                       category: .stem,
                       requirements: ["Canadian post-secondary student", "Propane industry career interest"]),
            
            Scholarship(name: "Ontario Public Student Trustee Leadership Scholarship",
                       amount: 500,
                       deadline: ontarioTrusteeDate,
                       description: "For student trustees demonstrating leadership in education.",
                       category: .humanities,
                       requirements: ["Ontario student trustee", "Leadership initiative", "Post-secondary enrollment"]),
            
            Scholarship(name: "James Kreppner Memorial Scholarship",
                       amount: 5000,
                       deadline: jamesKreppnerDate,
                       description: "For Canadians with inherited bleeding disorders and their families.",
                       category: .stem,
                       requirements: ["Bleeding disorder diagnosis", "Canadian resident", "Community service"]),
            
            Scholarship(name: "Ed Bitz Scholarship",
                       amount: 1000,
                       deadline: edBitzDate,
                       description: "For softball umpires pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Softball Canada umpire", "Canadian citizen/PR", "Post-secondary enrollment"]),
            
            Scholarship(name: "Troop 17 Scholarship",
                       amount: 1000,
                       deadline: troop17Date,
                       description: "For students promoting anti-bullying initiatives.",
                       category: .general,
                       requirements: ["Canadian citizen/PR", "Anti-bullying leadership", "Post-secondary enrollment"]),
            
            Scholarship(name: "OPP Youth Foundation Bursary",
                       amount: 1000,
                       deadline: oppYouthDate,
                       description: "For students connected to law enforcement communities.",
                       category: .general,
                       requirements: ["Aged 17-24", "Canadian post-secondary enrollment", "Financial need"]),
            
            Scholarship(name: "Cara Brown Ringette Canada Scholarship",
                       amount: 1500,
                       deadline: caraBrownDate,
                       description: "For competitive ringette players pursuing university education.",
                       category: .general,
                       requirements: ["Registered ringette player", "B average", "Canadian university enrollment"]),
            
            Scholarship(name: "Childhood Cancer Canada CIBC Survivor Scholarship",
                       amount: 5000,
                       deadline: childhoodCancerDate,
                       description: "For childhood cancer survivors pursuing higher education.",
                       category: .general,
                       requirements: ["Childhood cancer survivor", "Canadian citizen/PR", "Post-secondary enrollment"]),
            
            Scholarship(name: "Autism Ontario Post-Secondary Scholarship",
                       amount: 500,
                       deadline: autismOntarioDate,
                       description: "For Ontario students on the autism spectrum or with family connections to autism.",
                       category: .general,
                       requirements: ["Ontario resident", "Autism connection", "1st year post-secondary"]),
            
            Scholarship(name: "SMILE Bursaries",
                       amount: 1000,
                       deadline: smileBursariesDate,
                       description: "For low-income single mothers pursuing education.",
                       category: .general,
                       requirements: ["Single mother", "Canadian citizen/PR", "Financial need", "Post-secondary enrollment"]),
            
            Scholarship(name: "Lift Parts Express Scholarship",
                       amount: 500,
                       deadline: liftPartsExpressDate,
                       description: "For students in technical and trade programs.",
                       category: .stem,
                       requirements: ["Aged 16-21", "2.5+ GPA", "US/Canadian resident", "Essay required"]),
            
            Scholarship(name: "Foresters Financial Competitive Scholarship Program",
                       amount: 2000,
                       deadline: forestersFinancialDate,
                       description: "For Foresters members and their families pursuing higher education.",
                       category: .business,
                       requirements: ["Foresters member/family", "50+ community service hours", "80%+ average"]),
            
            Scholarship(name: "Bayer Crop Science Opportunity Scholarship",
                       amount: 5000,
                       deadline: bayerCropScienceDate,
                       description: "For students entering agriculture or food science programs.",
                       category: .stem,
                       requirements: ["Canadian citizen/PR", "High school senior", "Agriculture/food science program", "Essay required"]),
            
            Scholarship(name: "EDC Scholarships",
                       amount: 5000,
                       deadline: edcDate,
                       description: "For students interested in international business and trade.",
                       category: .business,
                       requirements: ["Canadian post-secondary student", "70%+ average", "Additional criteria vary"]),
            
            Scholarship(name: "Young Gassers CPA Student Scholarship",
                       amount: 1000,
                       deadline: youngGassersDate,
                       description: "For family members of CPA member company employees.",
                       category: .general,
                       requirements: ["Family of CPA member employee", "Canadian post-secondary enrollment"]),
            
            Scholarship(name: "Jack A. MacDonald Award of Merit",
                       amount: 500,
                       deadline: jackMacDonaldDate,
                       description: "For outstanding OPSBA student leaders in Ontario.",
                       category: .general,
                       requirements: ["OPSBA member school", "Academic excellence", "Community service", "Leadership"]),
            
            Scholarship(name: "Leavitt Machinery Scholarship Program",
                       amount: 500,
                       deadline: leavittMachineryDate,
                       description: "For students pursuing degrees in equipment and machinery fields.",
                       category: .stem,
                       requirements: ["2.5+ GPA", "US/Canadian resident", "2+ year degree program", "Essay required"]),
            
            Scholarship(name: "Odenza Vacations College Scholarship",
                       amount: 500,
                       deadline: odenzaVacationsDate,
                       description: "For students interested in travel and hospitality careers.",
                       category: .business,
                       requirements: ["Aged 17-24", "2.5+ GPA", "US/Canadian resident", "Essay required"]),
            
            Scholarship(name: "Ilana and Steven Rubin Education Scholarship",
                       amount: 1800,
                       deadline: ilanaRubinDate,
                       description: "For Ontario and Maritime students with 60-79% average.",
                       category: .general,
                       requirements: ["Ontario/Maritime high school senior", "60-79% average", "Canadian/PR (3+ years)", "Canadian/Israeli institution"]),
            
            Scholarship(name: "Loblaw Scholarship Program",
                       amount: 1500,
                       deadline: loblawDate,
                       description: "For Canadian students with community involvement.",
                       category: .business,
                       requirements: ["Canadian citizen/PR", "70%+ average", "Volunteer experience"]),
        ])
        
        // New scholarship dates
        let blackCanadianDate = dateFormatter.date(from: "May 30, 2025")!
        let lotusLightDate = dateFormatter.date(from: "May 31, 2025")!
        let cliffBennettDate = dateFormatter.date(from: "May 1, 2025")!
        let tcEnergyTradesDate = dateFormatter.date(from: "May 2, 2025")!
        let tcEnergyIndigenousDate = dateFormatter.date(from: "May 2, 2025")!
        let tcEnergyStemDate = dateFormatter.date(from: "May 2, 2025")!
        let kathleenBlinkhornDate = dateFormatter.date(from: "May 2, 2025")!
        let kpmgSparkDate = dateFormatter.date(from: "May 4, 2025")!
        let myBlueprintDate = dateFormatter.date(from: "May 7, 2025")!
        let rickHansenDate = dateFormatter.date(from: "May 14, 2025")!
        let agingMattersDate = dateFormatter.date(from: "May 15, 2025")!
        let bgcOttawaDate = dateFormatter.date(from: "May 15, 2025")!
        let aisTechnolabsDate = dateFormatter.date(from: "May 15, 2025")!
        let canterburyDate = dateFormatter.date(from: "May 16, 2025")!
        let medavieDate = dateFormatter.date(from: "May 17, 2025")!
        let rcafDate = dateFormatter.date(from: "May 22, 2025")!
        let reasonOneDate = dateFormatter.date(from: "May 23, 2025")!
        let lernersDate = dateFormatter.date(from: "May 25, 2025")!
        let lawBursariesDate = dateFormatter.date(from: "May 28, 2025")!
        let ironWorkersDate = dateFormatter.date(from: "May 30, 2025")!
        let aebcDate = dateFormatter.date(from: "May 30, 2025")!
        let ireneAdlerDate = dateFormatter.date(from: "May 30, 2025")!
        let lupusCanadaDate = dateFormatter.date(from: "May 31, 2025")!
        let maddDate = dateFormatter.date(from: "May 31, 2025")!
        let celineTowerDate = dateFormatter.date(from: "May 31, 2025")!
        let lincolnAlexanderDate = dateFormatter.date(from: "May 31, 2025")!
        let lukeSantiDate = dateFormatter.date(from: "May 31, 2025")!
        let terenceWhittyDate = dateFormatter.date(from: "May 31, 2025")!
        let spinalCordDate = dateFormatter.date(from: "May 31, 2025")!
        let laurierAugerDate = dateFormatter.date(from: "May 31, 2025")!
        let uneHighSchoolDate = dateFormatter.date(from: "May 31, 2025")!
        let abbottFennerDate = dateFormatter.date(from: "June 10, 2025")!
        let shimLawDate = dateFormatter.date(from: "June 30, 2025")!
        let bridgesEduDate = dateFormatter.date(from: "June 30, 2025")!

        // Add new scholarships
        scholarships.append(contentsOf: [
            Scholarship(name: "Black Canadian Scholarship Fund",
                       amount: 6000,
                       deadline: blackCanadianDate,
                       description: "For Black students in Ottawa pursuing university education.",
                       category: .general,
                       requirements: ["Black Canadian", "Ottawa high school", "75-90% average", "Community leadership", "Financial need"]),
            
            Scholarship(name: "Lotus Light Charity Society Scholarship",
                       amount: 500,
                       deadline: lotusLightDate,
                       description: "For students committed to community service.",
                       category: .general,
                       requirements: ["17+ years old", "Canadian post-secondary student", "Community involvement"]),
            
            Scholarship(name: "Cliff Bennett Nature Bursary",
                       amount: 1000,
                       deadline: cliffBennettDate,
                       description: "For students in environmental studies from Lanark County/West Carleton.",
                       category: .stem,
                       requirements: ["Environmental studies major", "Lanark/West Carleton resident", "MVFN membership (asset)"]),
            
            Scholarship(name: "TC Energy Trades Scholarship",
                       amount: 2500,
                       deadline: tcEnergyTradesDate,
                       description: "For students in trades programs relevant to energy.",
                       category: .stem,
                       requirements: ["Trades program enrollment", "Energy industry relevance"]),
            
            Scholarship(name: "TC Energy Indigenous Legacy Scholarship",
                       amount: 5000,
                       deadline: tcEnergyIndigenousDate,
                       description: "For Indigenous students pursuing post-secondary education.",
                       category: .general,
                       requirements: ["First Nations, Métis, or Inuit", "Post-secondary enrollment"]),
            
            Scholarship(name: "TC Energy STEM Scholarship",
                       amount: 5000,
                       deadline: tcEnergyStemDate,
                       description: "For students in STEM fields relevant to energy.",
                       category: .stem,
                       requirements: ["STEM program enrollment", "Energy industry relevance"]),
            
            Scholarship(name: "Kathleen Blinkhorn Indigenous Student Scholarship",
                       amount: 2000,
                       deadline: kathleenBlinkhornDate,
                       description: "For Indigenous students in non-profit housing.",
                       category: .general,
                       requirements: ["Indigenous identity", "Ontario non-profit housing resident", "Post-secondary enrollment"]),
            
            Scholarship(name: "KPMG SPARK Scholarship",
                       amount: 2000,
                       deadline: kpmgSparkDate,
                       description: "For future business and STEM leaders.",
                       category: .business,
                       requirements: ["High school senior", "65%+ average", "Business/STEM program", "Canadian citizen/PR"]),
            
            Scholarship(name: "myBlueprint x Scotiabank Scholarships",
                       amount: 3750,
                       deadline: myBlueprintDate,
                       description: "For students passionate about financial wellness and diversity.",
                       category: .business,
                       requirements: ["Canadian citizen/PR", "High school senior", "Themes: Diversity, Financial Wellness, Future Women Leaders, STEM"]),
            
            Scholarship(name: "Rick & Amanda Hansen Scholarship for Youth with Disabilities",
                       amount: 10000,
                       deadline: rickHansenDate,
                       description: "For Canadian youth with disabilities pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Person with disability", "Under 30 years old", "Canadian citizen/PR", "Post-secondary enrollment"]),
            
            Scholarship(name: "Aging Matters Scholarship",
                       amount: 1500,
                       deadline: agingMattersDate,
                       description: "For students impacting senior care and aging populations.",
                       category: .stem,
                       requirements: ["Senior care experience/interest", "Essay required"]),
            
            Scholarship(name: "BGC Ottawa Scholarships",
                       amount: 0, // Varies
                       deadline: bgcOttawaDate,
                       description: "For current/past BGC Ottawa members and volunteers.",
                       category: .general,
                       requirements: ["BGC Ottawa member/volunteer", "1st year post-secondary", "18 or under"]),
            
            Scholarship(name: "AIS Technolabs Engineering Scholarship",
                       amount: 5000,
                       deadline: aisTechnolabsDate,
                       description: "For engineering students in Canada, US, or Australia.",
                       category: .stem,
                       requirements: ["Engineering program enrollment", "Project submission required"]),
            
            Scholarship(name: "Canterbury Community Association Scholarships",
                       amount: 1000,
                       deadline: canterburyDate,
                       description: "For Alta Vista students demonstrating community leadership.",
                       category: .general,
                       requirements: ["Alta Vista resident/student", "Volunteer experience", "Post-secondary enrollment"]),
            
            Scholarship(name: "Medavie Scholarship",
                       amount: 7000,
                       deadline: medavieDate,
                       description: "For students affected by mental health challenges.",
                       category: .stem,
                       requirements: ["Aged 17-25", "Canadian citizen/PR", "Health-related field", "Mental health experience"]),
            
            Scholarship(name: "RCAF Foundation Student Scholarship",
                       amount: 1000,
                       deadline: rcafDate,
                       description: "For students pursuing aviation and aerospace careers.",
                       category: .stem,
                       requirements: ["Under 25 years old", "STEM program enrollment", "Aviation interest"]),
            
            Scholarship(name: "Reason One Mentorship & Scholarship Program",
                       amount: 5000,
                       deadline: reasonOneDate,
                       description: "For Black students in digital technology fields.",
                       category: .stem,
                       requirements: ["Black/African descent", "Ontario resident", "Digital/tech program", "Financial need"]),
            
            Scholarship(name: "Learn with Lerners' Bursary & Mentorship Program",
                       amount: 5000,
                       deadline: lernersDate,
                       description: "For racialized students interested in legal careers.",
                       category: .humanities,
                       requirements: ["BIPOC student", "Ontario post-secondary", "Legal career interest", "21 or under"]),
            
            Scholarship(name: "Bursaries for Studies Toward a Career in Law",
                       amount: 1000,
                       deadline: lawBursariesDate,
                       description: "For Ontario students pursuing legal careers.",
                       category: .humanities,
                       requirements: ["Ontario high school senior", "Legal studies program", "Financial need", "Academic excellence"]),
            
            Scholarship(name: "Iron Workers Scholarship",
                       amount: 500,
                       deadline: ironWorkersDate,
                       description: "For children of Iron Workers union members.",
                       category: .stem,
                       requirements: ["Union member's child", "Top 50% of class", "Post-secondary enrollment"]),
            
            Scholarship(name: "AEBC/Allyant Scholarship Program",
                       amount: 1000,
                       deadline: aebcDate,
                       description: "For blind or partially sighted Canadian students.",
                       category: .general,
                       requirements: ["Blind/partially sighted", "Canadian citizen/PR", "Post-secondary enrollment"]),
            
            Scholarship(name: "Irene Adler Prize",
                       amount: 250,
                       deadline: ireneAdlerDate,
                       description: "For women in journalism, creative writing, or literature.",
                       category: .arts,
                       requirements: ["Female student", "Writing-related program"]),
            
            Scholarship(name: "Lupus Canada William Birchall Foundation Scholarship",
                       amount: 2500,
                       deadline: lupusCanadaDate,
                       description: "For Canadian students with lupus pursuing education.",
                       category: .stem,
                       requirements: ["Lupus diagnosis", "Canadian post-secondary student", "Academic achievement"]),
            
            Scholarship(name: "MADD Canada Bursary Program",
                       amount: 5000,
                       deadline: maddDate,
                       description: "For those impacted by impaired driving incidents.",
                       category: .general,
                       requirements: ["Canadian citizen", "Impaired driving impact", "Post-secondary enrollment"]),
            
            Scholarship(name: "Celine Tower Grant",
                       amount: 1000,
                       deadline: celineTowerDate,
                       description: "For Alta Vista students in writing/journalism.",
                       category: .humanities,
                       requirements: ["Writing/journalism program", "Alta Vista resident/student", "Essay required"]),
            
            Scholarship(name: "Lincoln M. Alexander Award",
                       amount: 5000,
                       deadline: lincolnAlexanderDate,
                       description: "For Ontario students fighting racial discrimination.",
                       category: .general,
                       requirements: ["Ontario resident", "Anti-racism leadership", "Post-secondary enrollment"]),
            
            Scholarship(name: "Luke Santi Memorial Award for Student Achievement",
                       amount: 1000,
                       deadline: lukeSantiDate,
                       description: "For students in physical sciences programs.",
                       category: .stem,
                       requirements: ["Physical sciences program", "Canadian university", "Extracurricular involvement"]),
            
            Scholarship(name: "Major Terence Whitty Memorial Bursary",
                       amount: 1000,
                       deadline: terenceWhittyDate,
                       description: "For Army Cadets pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Active Army Cadet", "Financial need", "Post-secondary enrollment"]),
            
            Scholarship(name: "Spinal Cord Injury Canada Scholarships",
                       amount: 1000,
                       deadline: spinalCordDate,
                       description: "For Canadian students with spinal cord injuries.",
                       category: .general,
                       requirements: ["Spinal cord injury", "Canadian citizen/PR", "Post-secondary enrollment"]),
            
            Scholarship(name: "Laurier Auger Bursary",
                       amount: 2000,
                       deadline: laurierAugerDate,
                       description: "For Union of National Employees members and families.",
                       category: .general,
                       requirements: ["UNE member/family", "1st year post-secondary", "Financial need", "Essay required"]),
            
            Scholarship(name: "Union of National Employees High School Scholarships",
                       amount: 1000,
                       deadline: uneHighSchoolDate,
                       description: "For high school students in UNE regions.",
                       category: .general,
                       requirements: ["High school student", "UNE region resident", "Essay required"]),
            
            Scholarship(name: "Abbott & Fenner Scholarships",
                       amount: 1000,
                       deadline: abbottFennerDate,
                       description: "For high school and college students pursuing higher education.",
                       category: .business,
                       requirements: ["High school junior/senior or college student", "Essay required"]),
            
            Scholarship(name: "BigSun Scholarship",
                       amount: 500,
                       deadline: bigSunDate,
                       description: "For student-athletes pursuing higher education.",
                       category: .general,
                       requirements: ["High school senior", "Any sport", "Essay required"]),
            
            Scholarship(name: "Shim Law Scholarship",
                       amount: 1000,
                       deadline: shimLawDate,
                       description: "For students interested in legal studies.",
                       category: .humanities,
                       requirements: ["Canadian/American college/university student", "Infographic submission required"]),
            
            Scholarship(name: "BridgesEDU Scholarships",
                       amount: 1000,
                       deadline: bridgesEduDate,
                       description: "For Canadian students pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Canadian student", "Post-secondary enrollment", "Essay required"]),
        ])
        
        // New scholarship dates
        let knightsColumbusDate = dateFormatter.date(from: "June 1, 2025")!
        let inspiredLearningDate = dateFormatter.date(from: "June 1, 2025")!

        let annaPylesDate = dateFormatter.date(from: "June 2, 2025")!
        let emmyDuffDate = dateFormatter.date(from: "June 5, 2025")!
        let heoDate = dateFormatter.date(from: "June 6, 2025")!

        let abbvieDate = dateFormatter.date(from: "June 9, 2025")!
        let biotalentDate = dateFormatter.date(from: "June 10, 2025")!
        let golfCanadaDate = dateFormatter.date(from: "June 12, 2025")!
        let clacDate = dateFormatter.date(from: "June 13, 2025")!
        let oasboDate = dateFormatter.date(from: "June 13, 2025")!
        let josephDoriaDate = dateFormatter.date(from: "June 13, 2025")!
        let opterusDate = dateFormatter.date(from: "June 13, 2025")!
        let barbadosDate = dateFormatter.date(from: "June 13, 2025")!

        // Add new scholarships
        scholarships.append(contentsOf: [
            Scholarship(name: "FWIO Provincial Scholarship",
                       amount: 1000,
                       deadline: fwioDate,
                       description: "For Ontario women entering post-secondary education.",
                       category: .general,
                       requirements: ["Ontario resident", "Female student", "First year post-secondary", "75%+ average", "Essay required"]),
            
            Scholarship(name: "Knights of Columbus Ontario Bursary",
                       amount: 1000,
                       deadline: knightsColumbusDate,
                       description: "For children of Knights of Columbus members in Ontario.",
                       category: .general,
                       requirements: ["K of C Squires member or child of member", "First year post-secondary", "Ontario institution"]),
            
            Scholarship(name: "Inspired by Learning Education Bursary",
                       amount: 1000,
                       deadline: inspiredLearningDate,
                       description: "For Ottawa Community Housing residents pursuing education.",
                       category: .general,
                       requirements: ["OCH tenant", "Post-secondary enrollment", "Financial need"]),
            
            Scholarship(name: "OTIP Bursary Program",
                       amount: 1500,
                       deadline: otipDate,
                       description: "For families of OTIP insurance policyholders.",
                       category: .business,
                       requirements: ["OTIP policyholder's relative", "Canadian post-secondary student", "Random draw"]),
            
            Scholarship(name: "Anna Pyles Memorial Scholarship",
                       amount: 500,
                       deadline: annaPylesDate,
                       description: "For students promoting road safety through OSAID.",
                       category: .general,
                       requirements: ["OSAID chapter member", "Organized safety activities", "High school senior"]),
            
            Scholarship(name: "Emmy Duff Scholarship Foundation",
                       amount: 2000,
                       deadline: emmyDuffDate,
                       description: "For Canadian cancer survivors pursuing higher education.",
                       category: .stem,
                       requirements: ["Cancer treatment history", "Canadian citizen/PR", "Post-secondary enrollment", "Volunteer commitment"]),
            
            Scholarship(name: "HEO Bursary",
                       amount: 500,
                       deadline: heoDate,
                       description: "For Hockey Eastern Ontario players continuing education.",
                       category: .general,
                       requirements: ["HEO registered player", "High school graduate", "Post-secondary enrollment"]),
            
            Scholarship(name: "For the Love of Curling Scholarship",
                       amount: 2500,
                       deadline: curlingDate,
                       description: "For competitive curlers pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Canadian citizen", "Under 22 years old", "70%+ average", "Curling achievements"]),
            
            Scholarship(name: "AbbVie IBD Scholarship",
                       amount: 5000,
                       deadline: abbvieDate,
                       description: "For students with Crohn's or colitis pursuing education.",
                       category: .stem,
                       requirements: ["Crohn's/colitis diagnosis", "Canadian citizen/PR", "Post-secondary enrollment"]),
            
            Scholarship(name: "BioTalent Canada I.D.E.A.L. Scholarship",
                       amount: 10000,
                       deadline: biotalentDate,
                       description: "For diverse students in bioscience programs.",
                       category: .stem,
                       requirements: ["Equity-deserving group", "First year bioscience program", "Leadership in diversity"]),
            
            Scholarship(name: "Golf Canada Foundation Scholarships",
                       amount: 1500,
                       deadline: golfCanadaDate,
                       description: "For competitive golfers in Canadian post-secondary.",
                       category: .general,
                       requirements: ["Canadian university/college golf program", "Amateur status"]),
            
            Scholarship(name: "CLAC Scholarships",
                       amount: 1500,
                       deadline: clacDate,
                       description: "For CLAC union members and families.",
                       category: .general,
                       requirements: ["CLAC member/family", "Canadian post-secondary enrollment"]),
            
            Scholarship(name: "OASBO Scholarship Fund",
                       amount: 3000,
                       deadline: oasboDate,
                       description: "For families of school board employees in Ontario.",
                       category: .general,
                       requirements: ["OASBO member's dependent", "Canadian post-secondary enrollment"]),
            
            Scholarship(name: "Joseph G. Doria Exemplary Student Award",
                       amount: 3000,
                       deadline: josephDoriaDate,
                       description: "For students pursuing welding careers.",
                       category: .stem,
                       requirements: ["Canadian high school senior", "Welding technician/engineering program", "Industry passion"]),
            
            Scholarship(name: "Opterus Rebel with a Cause Awards",
                       amount: 10000,
                       deadline: opterusDate,
                       description: "For young women in STEM or Arts programs.",
                       category: .stem,
                       requirements: ["Female student", "Aged 18-26", "Canadian post-secondary", "STEM/Arts program"]),
            
            Scholarship(name: "Barbados Canada Foundation Scholarships",
                       amount: 4000,
                       deadline: barbadosDate,
                       description: "For students of Barbadian heritage in Canada.",
                       category: .general,
                       requirements: ["Barbadian connection", "Canadian post-secondary student", "Under 30 years old"]),
        ])
        
        // New scholarship dates
        let csegDate = dateFormatter.date(from: "June 15, 2025")!
        let sobeysDate = dateFormatter.date(from: "June 15, 2025")!
        let ucbeyondDate = dateFormatter.date(from: "June 27, 2025")!
        let royCooperDate = dateFormatter.date(from: "June 27, 2025")!
        let consolidatedCreditDate = dateFormatter.date(from: "June 27, 2025")!
        let heritageClubDate = dateFormatter.date(from: "June 30, 2025")!
        let charlesLabatiukDate = dateFormatter.date(from: "June 30, 2025")!
        let scoutsCanadaDate = dateFormatter.date(from: "June 30, 2025")!
        let cafaDate = dateFormatter.date(from: "June 30, 2025")!
        let chaseoDate = dateFormatter.date(from: "June 30, 2025")!
        let horticulturalDate = dateFormatter.date(from: "June 30, 2025")!
        let mifflinDate = dateFormatter.date(from: "June 30, 2025")!
        let cuSucceedDate = dateFormatter.date(from: "June 30, 2025")!
        let uswDate = dateFormatter.date(from: "June 30, 2025")!
        let progressiveDate = dateFormatter.date(from: "June 30, 2025")!
        let bobClarkeDate = dateFormatter.date(from: "June 30, 2025")!
        let meganWhitfieldDate = dateFormatter.date(from: "June 30, 2025")!
        let hughPomeroyDate = dateFormatter.date(from: "June 30, 2025")!

        // Add new scholarships
        scholarships.append(contentsOf: [
            Scholarship(name: "AIA Canada & UofAF Scholarship",
                       amount: 1000,
                       deadline: aiaCanadaDate,
                       description: "For students in automotive aftermarket programs.",
                       category: .stem,
                       requirements: ["High school senior or college student", "Automotive program enrollment"]),
            
            Scholarship(name: "CSEG Foundation University Entrance Scholarship",
                       amount: 500,
                       deadline: csegDate,
                       description: "For students entering science programs with a focus on geophysics.",
                       category: .stem,
                       requirements: ["Canadian university enrollment", "Science program", "CSEG member's child (priority)"]),
            
            Scholarship(name: "Sobeys & Empire Scholarship Program",
                       amount: 1500,
                       deadline: sobeysDate,
                       description: "For Sobeys employees and their families.",
                       category: .business,
                       requirements: ["Sobeys employee (6+ months)", "70%+ average", "Canadian post-secondary enrollment"]),
            
            Scholarship(name: "American Muscle Student Scholarship",
                       amount: 2500,
                       deadline: americanMuscleDate,
                       description: "For students in automotive engineering programs.",
                       category: .stem,
                       requirements: ["Automotive engineering student", "US/Canadian institution", "Essay required"]),
            
            Scholarship(name: "PSAC Scholarship Program",
                       amount: 1000,
                       deadline: psacDate,
                       description: "For PSAC union members and families.",
                       category: .general,
                       requirements: ["PSAC member's child", "Creative submission required"]),
            
            Scholarship(name: "UCBeyond Scholarship Program",
                       amount: 5000,
                       deadline: ucbeyondDate,
                       description: "For students with chronic inflammatory diseases.",
                       category: .stem,
                       requirements: ["Inflammatory disease diagnosis", "Canadian post-secondary student"]),
            
            Scholarship(name: "Roy Cooper Memorial Scholarship",
                       amount: 1000,
                       deadline: royCooperDate,
                       description: "For Ontario students with learning disabilities in STEM.",
                       category: .stem,
                       requirements: ["Documented learning disability", "Ontario high school senior", "Engineering/physical sciences program"]),
            
            Scholarship(name: "Consolidated Credit Canada Scholarship",
                       amount: 500,
                       deadline: consolidatedCreditDate,
                       description: "For Canadian students promoting financial literacy.",
                       category: .business,
                       requirements: ["Canadian resident", "Post-secondary enrollment", "Essay required"]),
            
            Scholarship(name: "ONECA Four Directions Scholarship",
                       amount: 1000,
                       deadline: onecaDate,
                       description: "For Indigenous students in Ontario pursuing higher education.",
                       category: .general,
                       requirements: ["Indigenous ancestry", "Ontario high school", "75%+ average", "Community involvement"]),
            
            Scholarship(name: "Heritage Club Scholarship Program",
                       amount: 2000,
                       deadline: heritageClubDate,
                       description: "For Heritage Club members' descendants.",
                       category: .general,
                       requirements: ["Heritage Club member's child/grandchild", "75%+ average", "Canadian post-secondary enrollment"]),
            
            Scholarship(name: "Charles Labatiuk Scholarship",
                       amount: 1000,
                       deadline: charlesLabatiukDate,
                       description: "For students in environmental systems programs.",
                       category: .stem,
                       requirements: ["Environmental systems program", "Canadian post-secondary institution", "Essay required"]),
            
            Scholarship(name: "Scouts Canada Scholarship Program",
                       amount: 6000,
                       deadline: scoutsCanadaDate,
                       description: "For active Scouts Canada members pursuing education.",
                       category: .general,
                       requirements: ["Scouts Canada member", "Under 26 years old", "Scouting achievements"]),
            
            Scholarship(name: "Canadian Airborne Forces Association Scholarship",
                       amount: 3000,
                       deadline: cafaDate,
                       description: "For CAFA/ARAC affiliates in post-secondary.",
                       category: .general,
                       requirements: ["CAFA/ARAC affiliation", "Post-secondary enrollment", "Academic achievement"]),
            
            Scholarship(name: "CHASEO Diversity Scholarship",
                       amount: 2000,
                       deadline: chaseoDate,
                       description: "For CHASEO member co-op residents promoting diversity.",
                       category: .general,
                       requirements: ["CHASEO co-op resident", "Canadian post-secondary enrollment", "Diversity leadership"]),
            
            Scholarship(name: "Ontario Horticultural Trades Foundation Scholarships",
                       amount: 500,
                       deadline: horticulturalDate,
                       description: "For Ontario students in landscape and horticulture.",
                       category: .stem,
                       requirements: ["Ontario resident", "First year horticulture program"]),
            
            Scholarship(name: "Rear-Admiral Fred Mifflin Memorial Scholarship",
                       amount: 3000,
                       deadline: mifflinDate,
                       description: "For Sea Cadets pursuing maritime education.",
                       category: .general,
                       requirements: ["Active Sea Cadet", "Maritime-focused program", "Community service"]),
            
            Scholarship(name: "CU Succeed Youth Bursary Program",
                       amount: 1000,
                       deadline: cuSucceedDate,
                       description: "For Ontario credit union members' children.",
                       category: .business,
                       requirements: ["OCUF credit union member/family", "Under 25", "65%+ average", "Community involvement"]),
            
            Scholarship(name: "USW Scholarships",
                       amount: 1000,
                       deadline: uswDate,
                       description: "For United Steelworkers members and families.",
                       category: .general,
                       requirements: ["USW member's child", "Under 25", "Video/written submission required"]),
            
            Scholarship(name: "Progressive Automations Scholarship",
                       amount: 2500,
                       deadline: progressiveDate,
                       description: "For engineering students in automation fields.",
                       category: .stem,
                       requirements: ["Engineering program enrollment", "US/Canadian institution", "Project idea required"]),
            
            Scholarship(name: "Bob Clarke Automotive Memorial Scholarship",
                       amount: 2500,
                       deadline: bobClarkeDate,
                       description: "For students in automotive apprenticeship programs.",
                       category: .stem,
                       requirements: ["Secondary automotive program completion", "Red Seal apprenticeship plan", "Professionalism"]),
            
            Scholarship(name: "Russell Alexander Law Scholarship",
                       amount: 2500,
                       deadline: russellAlexanderDate,
                       description: "For students pursuing legal careers in Canada.",
                       category: .humanities,
                       requirements: ["Canadian high school senior", "80%+ average", "Legal career interest", "Essay required"]),
            
            Scholarship(name: "Megan Whitfield Bursary",
                       amount: 2500,
                       deadline: meganWhitfieldDate,
                       description: "For equity-seeking students in labor/human rights programs.",
                       category: .humanities,
                       requirements: ["CUPW member's child", "Labor/Human Rights program", "Creative submission required"]),
            
            Scholarship(name: "Hugh Pomeroy Scholarship",
                       amount: 0, // Varies
                       deadline: hughPomeroyDate,
                       description: "For national team members in Canadian snow sports.",
                       category: .general,
                       requirements: ["National team member (1+ year)", "Canadian Snowsports Association discipline", "Education pursuit"]),
        ])
        
        // New scholarship dates
        let doubleADate = dateFormatter.date(from: "July 1, 2025")!
        let janitorialDate = dateFormatter.date(from: "July 1, 2025")!
        let onaDate = dateFormatter.date(from: "July 1, 2025")!
        let agmaDate = dateFormatter.date(from: "July 1, 2025")!
        let bbpaDate = dateFormatter.date(from: "July 1, 2025")!
        let jimBourqueDate = dateFormatter.date(from: "July 8, 2025")!
        let ttaoDate = dateFormatter.date(from: "July 14, 2025")!
        let otaDate = dateFormatter.date(from: "July 15, 2025")!
        let nupgeDate = dateFormatter.date(from: "July 15, 2025")!
        let ccmwDate = dateFormatter.date(from: "July 15, 2025")!
        let buckhornDate = dateFormatter.date(from: "July 18, 2025")!
        let iamhDate = dateFormatter.date(from: "July 26, 2025")!
        let mdecDate = dateFormatter.date(from: "July 30, 2025")!
        let opseuDate = dateFormatter.date(from: "July 31, 2025")!
        let deBeersDate = dateFormatter.date(from: "July 31, 2025")!
        let edCoatesDate = dateFormatter.date(from: "July 31, 2025")!
        let saulFeldbergDate = dateFormatter.date(from: "July 31, 2025")!
        let capsleDate = dateFormatter.date(from: "July 31, 2025")!
        let bfcnDate = dateFormatter.date(from: "July 31, 2025")!
        let phylissMcCarthyDate = dateFormatter.date(from: "July 23, 2025")!
        let wizeDate = dateFormatter.date(from: "July 31, 2025")!
        let summitDate = dateFormatter.date(from: "August 31, 2025")!
        let dennisMcGannDate = dateFormatter.date(from: "August 1, 2025")!
        let opffaDate = dateFormatter.date(from: "August 1, 2025")!
        let tamaraGordonDate = dateFormatter.date(from: "August 2, 2025")!
        let skillsOntarioDate = dateFormatter.date(from: "August 2, 2025")!
        let liveBrightDate = dateFormatter.date(from: "August 7, 2025")!
        let wallyMcIntoshDate = dateFormatter.date(from: "August 9, 2025")!
        let ucteDate = dateFormatter.date(from: "August 14, 2025")!
        let execulinkDate = dateFormatter.date(from: "August 15, 2025")!
        let rcrDate = dateFormatter.date(from: "August 15, 2025")!
        let epilepsyDate = dateFormatter.date(from: "August 16, 2025")!
        let oppaDate = dateFormatter.date(from: "August 16, 2025")!
        let ecaoDate = dateFormatter.date(from: "August 16, 2025")!
        let uhewDate = dateFormatter.date(from: "August 23, 2025")!
        let gsuDate = dateFormatter.date(from: "August 30, 2025")!

        // Add new scholarships
        scholarships.append(contentsOf: [
            Scholarship(name: "Double A Solutions Scholarship",
                       amount: 1000,
                       deadline: doubleADate,
                       description: "For high school seniors and college students pursuing higher education.",
                       category: .business,
                       requirements: ["High school senior or college student", "US/Canadian institution", "Essay required"]),
            
            Scholarship(name: "Janitorial Manager Scholarship",
                       amount: 1000,
                       deadline: janitorialDate,
                       description: "For students pursuing education in business or related fields.",
                       category: .business,
                       requirements: ["High school senior or college student", "US/Canadian institution", "Essay required"]),
            
            Scholarship(name: "WHSC Student Scholarship Contest",
                       amount: 2000,
                       deadline: whscDate,
                       description: "For Ontario students promoting workplace health and safety.",
                       category: .general,
                       requirements: ["Ontario high school student", "Starting college/university in fall 2025", "Essay/poster/video submission"]),
            
            Scholarship(name: "ONA & CFNU Nursing Scholarships",
                       amount: 1000,
                       deadline: onaDate,
                       description: "For family members of ONA members entering nursing programs.",
                       category: .stem,
                       requirements: ["ONA member's family", "First year nursing student", "Ontario resident", "Essay required"]),
            
            Scholarship(name: "AGMA Foundation Scholarship",
                       amount: 2500,
                       deadline: agmaDate,
                       description: "For students pursuing careers in gear industry and power transmission.",
                       category: .stem,
                       requirements: ["GPA 3.0+", "Internship/work experience", "Community involvement", "Financial need"]),
            
            Scholarship(name: "BBPA National Scholarship Program",
                       amount: 1000,
                       deadline: bbpaDate,
                       description: "For Black Canadian students demonstrating academic excellence and community leadership.",
                       category: .general,
                       requirements: ["Canadian Black community member", "Under 30 years old", "Post-secondary enrollment", "Community contribution"]),
            
            Scholarship(name: "Mon Sheong Golden Jubilee Scholarship",
                       amount: 1000,
                       deadline: monSheongDate,
                       description: "For Ontario high school graduates with strong community involvement.",
                       category: .general,
                       requirements: ["Ontario high school graduate", "80%+ average", "Community engagement", "Leadership qualities"]),
            
            Scholarship(name: "Jim Bourque Scholarship",
                       amount: 1000,
                       deadline: jimBourqueDate,
                       description: "For Indigenous students in education, environment, or telecommunications.",
                       category: .general,
                       requirements: ["Indigenous student", "Canadian post-secondary enrollment", "Financial need"]),
            
            Scholarship(name: "TTAO Scholarship Awards",
                       amount: 1000,
                       deadline: ttaoDate,
                       description: "For TTAO members and families pursuing higher education.",
                       category: .general,
                       requirements: ["TTAO member/family", "Canadian post-secondary enrollment", "Community involvement"]),
            
            Scholarship(name: "OTA Education Foundation Scholarships",
                       amount: 1000,
                       deadline: otaDate,
                       description: "For families in Ontario's trucking industry.",
                       category: .general,
                       requirements: ["Parent in Ontario trucking industry", "Under 25", "Canadian post-secondary enrollment", "Essay required"]),
            
            Scholarship(name: "NUPGE Scholarships",
                       amount: 2500,
                       deadline: nupgeDate,
                       description: "For families of NUPGE union members.",
                       category: .general,
                       requirements: ["NUPGE member's child/grandchild", "Canadian post-secondary enrollment", "Essay required"]),
            
            Scholarship(name: "CCMW Lila Fahlman Scholarships",
                       amount: 1500,
                       deadline: ccmwDate,
                       description: "For Canadian Muslim women pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Muslim woman", "Canadian citizen/PR", "Undergraduate/certificate program", "Community involvement"]),
            
            Scholarship(name: "Support Our Troops Scholarship",
                       amount: 500,
                       deadline: supportTroopsDate,
                       description: "For dependents of Canadian Armed Forces members.",
                       category: .general,
                       requirements: ["CAF dependent", "Canadian citizen/PR", "Post-secondary enrollment", "Community service"]),
            
            Scholarship(name: "Buckhorn Fine Art Award",
                       amount: 500,
                       deadline: buckhornDate,
                       description: "For emerging visual artists in Canada.",
                       category: .arts,
                       requirements: ["17+ years old", "Canadian art institution enrollment", "Community involvement"]),
            
            Scholarship(name: "Grain Farmers of Ontario Legacy Scholarship",
                       amount: 5000,
                       deadline: grainFarmersDate,
                       description: "For future leaders in Ontario's grain and agri-food sector.",
                       category: .stem,
                       requirements: ["Ontario resident", "Post-secondary enrollment", "Essay required"]),
            
            Scholarship(name: "IAMH Scholarship Program",
                       amount: 1000,
                       deadline: iamhDate,
                       description: "For students with schizophrenia/psychosis pursuing education.",
                       category: .stem,
                       requirements: ["Diagnosis of schizophrenia/psychosis", "In recovery plan", "Post-secondary enrollment"]),
            
            Scholarship(name: "MDEC Scholarships",
                       amount: 2000,
                       deadline: mdecDate,
                       description: "For students pursuing careers in the mining industry.",
                       category: .stem,
                       requirements: ["Academic achievement", "Community service", "Mining industry interest", "Essay required"]),
            
            Scholarship(name: "OPSEU/SEFPO Scholarships",
                       amount: 1000,
                       deadline: opseuDate,
                       description: "For families of OPSEU/SEFPO members in Ontario.",
                       category: .general,
                       requirements: ["OPSEU/SEFPO member's dependent", "Ontario post-secondary enrollment"]),
            
            Scholarship(name: "De Beers Group Scholarships for Canadian Women",
                       amount: 4500,
                       deadline: deBeersDate,
                       description: "For women in STEM programs, with preference for Indigenous women.",
                       category: .stem,
                       requirements: ["Canadian citizen/PR", "Female", "First year STEM program", "Indigenous preference"]),
            
            Scholarship(name: "Ed Coates Memorial Scholarship",
                       amount: 2500,
                       deadline: edCoatesDate,
                       description: "For students in automotive apprenticeship programs.",
                       category: .stem,
                       requirements: ["Secondary automotive program completion", "Red Seal apprenticeship plan", "Professionalism"]),
            
            Scholarship(name: "Saul Feldberg Memorial Scholarship",
                       amount: 1000,
                       deadline: saulFeldbergDate,
                       description: "For COPA member families pursuing higher education.",
                       category: .business,
                       requirements: ["COPA member/family", "Canadian citizen/PR", "80%+ average", "Random draw"]),
            
            Scholarship(name: "CAPSLE Bursary",
                       amount: 2000,
                       deadline: capsleDate,
                       description: "For students in education or law programs in Canada.",
                       category: .humanities,
                       requirements: ["Canadian university acceptance", "Education/Law program", "Underrepresented groups priority"]),
            
            Scholarship(name: "BFCN Scholarship Program",
                       amount: 1000,
                       deadline: bfcnDate,
                       description: "For Black students demonstrating academic achievement and community involvement.",
                       category: .general,
                       requirements: ["Black student", "Canadian post-secondary enrollment", "Financial need", "Community leadership"]),
            
            Scholarship(name: "Phyliss J. McCarthy Writing Scholarship",
                       amount: 1000,
                       deadline: phylissMcCarthyDate,
                       description: "For high school students demonstrating excellence in writing.",
                       category: .humanities,
                       requirements: ["High school junior/senior", "Essay submission"]),
            
            Scholarship(name: "Wize Canadian High School Scholarship",
                       amount: 1000,
                       deadline: wizeDate,
                       description: "For current high school students in Canada.",
                       category: .general,
                       requirements: ["High school enrollment", "No GPA requirement"]),
            
            Scholarship(name: "Summit Physical Therapy Scholarship",
                       amount: 500,
                       deadline: summitDate,
                       description: "For students in healthcare fields in the US or Canada.",
                       category: .stem,
                       requirements: ["GPA 3.0+", "US/Canadian resident", "College/university enrollment by January 2026", "Essay required"]),
            
            Scholarship(name: "Haywood & Hunt Annual Scholarship",
                       amount: 1000,
                       deadline: haywoodHuntDate,
                       description: "For Canadian students pursuing post-secondary education.",
                       category: .general,
                       requirements: ["Canadian citizen/PR", "Post-secondary enrollment", "Essay required"]),
            
            Scholarship(name: "Dennis McGann Bursary",
                       amount: 1000,
                       deadline: dennisMcGannDate,
                       description: "For communications students committed to labor issues.",
                       category: .humanities,
                       requirements: ["Canadian citizen/PR", "Communications program", "Labor movement interest", "Financial need", "Essay required"]),
            
            Scholarship(name: "Indspire Bursaries and Scholarships",
                       amount: 0, // Varies
                       deadline: indspireDate,
                       description: "For Indigenous students pursuing post-secondary education in Canada.",
                       category: .general,
                       requirements: ["Indigenous ancestry", "Canadian post-secondary enrollment"]),
            
            Scholarship(name: "OPFFA William T Sanders Lodd Memorial Fund",
                       amount: 500,
                       deadline: opffaDate,
                       description: "For children of OPFFA members who died in the line of duty.",
                       category: .general,
                       requirements: ["OPFFA member's child", "Post-secondary enrollment", "First year preference"]),
            
            Scholarship(name: "Bill 7 Award",
                       amount: 2000,
                       deadline: bill7Date,
                       description: "For LGBTQ+ students in Ontario facing financial barriers to education.",
                       category: .general,
                       requirements: ["LGBTQ+ identified", "Ontario post-secondary enrollment", "Financial need"]),
            
            Scholarship(name: "Tamara Gordon Foundation Scholarship",
                       amount: 0, // Varies
                       deadline: tamaraGordonDate,
                       description: "For Ontario students with physical disabilities pursuing higher education.",
                       category: .general,
                       requirements: ["Physical disability", "Ontario high school senior", "Strong academics", "Financial need"]),
            
            Scholarship(name: "Skills Ontario Scholarship",
                       amount: 1000,
                       deadline: skillsOntarioDate,
                       description: "For Skills Ontario Competition medalists continuing their education.",
                       category: .stem,
                       requirements: ["Ontario resident", "Skills Ontario medalist", "Post-secondary/apprenticeship enrollment"]),
            
            Scholarship(name: "LiveBright Scholarship Program",
                       amount: 2000,
                       deadline: liveBrightDate,
                       description: "For students demonstrating financial literacy and planning skills.",
                       category: .business,
                       requirements: ["Canadian resident", "Aged 16-25", "Post-secondary enrollment", "Essay on retirement planning"]),
            
            Scholarship(name: "Wally McIntosh Memorial Scholarship",
                       amount: 2500,
                       deadline: wallyMcIntoshDate,
                       description: "For families of OSMCA member companies' employees.",
                       category: .general,
                       requirements: ["OSMCA employee's child", "High school graduate", "Post-secondary enrollment", "Community involvement"]),
            
            Scholarship(name: "UCTE Dream Big Scholarships",
                       amount: 2500,
                       deadline: ucteDate,
                       description: "For UCTE union members' families pursuing post-secondary education.",
                       category: .general,
                       requirements: ["UCTE member's child/grandchild", "First year post-secondary", "Academic achievement or financial need", "Essay required"]),
            
            Scholarship(name: "Execulink Scholarship Program",
                       amount: 500,
                       deadline: execulinkDate,
                       description: "For Execulink Telecom customers and families pursuing STEM fields.",
                       category: .stem,
                       requirements: ["Execulink customer/family", "High school graduate", "STEM focus", "Community involvement"]),
            
            Scholarship(name: "RCR Association Bursary Program",
                       amount: 0, // Varies
                       deadline: rcrDate,
                       description: "For members of The Royal Canadian Regiment community pursuing higher education.",
                       category: .general,
                       requirements: ["RCR family member or cadet", "Post-secondary enrollment"]),
            
            Scholarship(name: "Epilepsy Ontario Scholarship",
                       amount: 1500,
                       deadline: epilepsyDate,
                       description: "For Ontario students living with epilepsy.",
                       category: .stem,
                       requirements: ["Epilepsy diagnosis", "Ontario resident", "Post-secondary enrollment"]),
            
            Scholarship(name: "OPPA Credit Union Scholarship",
                       amount: 1000,
                       deadline: oppaDate,
                       description: "For children of OPPA Credit Union members.",
                       category: .general,
                       requirements: ["OPPA Credit Union member's child", "First year post-secondary", "Random draw"]),
            
            Scholarship(name: "ECAO Scholarship Program",
                       amount: 0, // Varies
                       deadline: ecaoDate,
                       description: "For families of ECAO member company employees.",
                       category: .stem,
                       requirements: ["ECAO employee's child", "Canadian citizen", "Post-secondary enrollment", "Construction industry interest"]),
            
            Scholarship(name: "UHEW Scholarships",
                       amount: 3000,
                       deadline: uhewDate,
                       description: "For UHEW union members' dependents pursuing education.",
                       category: .general,
                       requirements: ["UHEW member's dependent", "Post-secondary enrollment", "Essay required"]),
            
            Scholarship(name: "GSU Bursaries",
                       amount: 2000,
                       deadline: gsuDate,
                       description: "For GSU union members' families pursuing post-secondary education.",
                       category: .general,
                       requirements: ["GSU member's dependent", "70%+ average", "Post-secondary enrollment", "Essay required"]),
        ])
        
        // New scholarship dates
        let cmeaDate = dateFormatter.date(from: "August 31, 2025")!
        let somaliDate = dateFormatter.date(from: "August 31, 2025")!
        let ofaDate = dateFormatter.date(from: "August 31, 2025")!
        let sonsOfNorwayDate = dateFormatter.date(from: "August 31, 2025")!
        let beeStudentDate = dateFormatter.date(from: "August 18, 2025")!

        // Add new scholarships
        scholarships.append(contentsOf: [
            Scholarship(name: "CMEA Bursary Program",
                       amount: 2000,
                       deadline: cmeaDate,
                       description: "For Canadian Military Engineer Association members and families.",
                       category: .general,
                       requirements: ["CMEA member/dependent", "Post-secondary enrollment", "Academic achievement", "Financial need"]),
            
            Scholarship(name: "Canadian Somali Scholarship Fund",
                       amount: 1000,
                       deadline: somaliDate,
                       description: "For Canadian Somali students pursuing higher education.",
                       category: .general,
                       requirements: ["Canadian Somali community member", "Canadian citizen/PR", "Post-secondary enrollment", "Academic achievement"]),
            
            Scholarship(name: "OFA Bursary Program",
                       amount: 2000,
                       deadline: ofaDate,
                       description: "For OFA members and families in Ontario agriculture.",
                       category: .stem,
                       requirements: ["OFA member/family/employee", "Ontario resident", "Post-secondary enrollment", "Agriculture interest"]),
            
            Scholarship(name: "Sons of Norway Foundation Bursaries",
                       amount: 400,
                       deadline: sonsOfNorwayDate,
                       description: "For students with Norwegian heritage in Canada.",
                       category: .general,
                       requirements: ["Canadian resident", "First degree/diploma/apprenticeship", "Norwegian connection"]),
            
            Scholarship(name: "BeeStudent Essay Contest",
                       amount: 600,
                       deadline: beeStudentDate,
                       description: "For high school and college students demonstrating writing excellence.",
                       category: .humanities,
                       requirements: ["High school/post-secondary student", "Essay submission"]),
        ])
        
        return scholarships
    }
} 