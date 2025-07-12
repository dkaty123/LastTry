import Foundation

public struct OpportunityData {
    public static func convertAndAddOpportunities() -> [Opportunity] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        
        var opportunities: [Opportunity] = []
        
        // Convert existing scholarships to opportunities
        let existingScholarships = ScholarshipData.convertAndAddScholarships()
        let scholarshipOpportunities = existingScholarships.map { Opportunity(from: $0) }
        opportunities.append(contentsOf: scholarshipOpportunities)
        
        // Add new opportunity types
        opportunities.append(contentsOf: createNewOpportunities(dateFormatter: dateFormatter))
        
        return opportunities
    }
    
    private static func createNewOpportunities(dateFormatter: DateFormatter) -> [Opportunity] {
        var opportunities: [Opportunity] = []
        
        // Sample internship opportunities
    
        // Sample conference opportunities
        opportunities.append(Opportunity(
            title: "Canada Youth Summit on Climate Action",
            type: .conference,
            category: .environment,
            organization: "EarthEcho International",
            description: "Connect with environmental leaders and innovators from across Canada.",
            requirements: ["Ages 16-25", "Passion for environment", "Leadership experience"],
            benefits: ["Travel covered", "Networking opportunities", "Skill development", "Action plan creation"],
            deadline: Date().addingTimeInterval(86400 * 20),
            startDate: Date().addingTimeInterval(86400 * 40),
            endDate: Date().addingTimeInterval(86400 * 43),
            location: "Vancouver, BC",
            isRemote: false,
            applicationUrl: "https://example.com/youth-summit",
            tags: ["climate", "youth", "leadership", "environment"]
        ))
        
        // Sample competition opportunities
        opportunities.append(Opportunity(
            title: "National Science Fair Competition",
            type: .competition,
            category: .stem,
            organization: "Youth Science Canada",
            description: "Showcase your scientific research and innovation.",
            requirements: ["Grades 7-12", "Original research project", "School nomination"],
            benefits: ["Cash prizes", "Recognition", "National exposure", "University connections"],
            deadline: Date().addingTimeInterval(86400 * 60),
            startDate: Date().addingTimeInterval(86400 * 90),
            endDate: Date().addingTimeInterval(86400 * 93),
            location: "Ottawa, ON",
            isRemote: false,
            amount: 5000,
            applicationUrl: "https://example.com/science-fair",
            tags: ["science", "competition", "research", "youth"]
        ))
        
        // Sample grant opportunities
        opportunities.append(Opportunity(
            title: "Summer Company Grant",
            type: .grant,
            category: .entrepreneurship,
            organization: "Ontario Government",
            description: "Start your own business with government support and mentorship.",
            requirements: ["Ages 15-29", "Ontario resident", "Business plan", "No previous business ownership"],
            benefits: ["$3,000 grant", "Business mentorship", "Workshop training", "Networking events"],
            deadline: Date().addingTimeInterval(86400 * 30),
            startDate: Date().addingTimeInterval(86400 * 60),
            endDate: Date().addingTimeInterval(86400 * 120),
            location: "Ontario",
            isRemote: true,
            amount: 3000,
            applicationUrl: "https://example.com/summer-company",
            tags: ["entrepreneurship", "grant", "business", "youth"]
        ))
        
        // Sample leadership program opportunities
        opportunities.append(Opportunity(
            title: "Duke of Edinburgh Award Program",
            type: .leadership,
            category: .communityService,
            organization: "Duke of Edinburgh's International Award",
            description: "Develop leadership skills through community service, physical activity, and personal development.",
            requirements: ["Ages 14-24", "Commitment to program", "Community involvement"],
            benefits: ["International recognition", "Leadership skills", "Personal growth", "University credit"],
            deadline: Date().addingTimeInterval(86400 * 45),
            startDate: Date().addingTimeInterval(86400 * 60),
            endDate: Date().addingTimeInterval(86400 * 365),
            location: "Canada-wide",
            isRemote: false,
            applicationUrl: "https://example.com/duke-of-edinburgh",
            tags: ["leadership", "service", "personal-development", "international"]
        ))
        
        // Sample volunteer opportunities
        opportunities.append(Opportunity(
            title: "UN Youth Volunteer Program",
            type: .volunteer,
            category: .socialJustice,
            organization: "United Nations",
            description: "Serve communities around the world while gaining valuable experience.",
            requirements: ["Ages 18-29", "University degree", "Language skills", "Commitment to service"],
            benefits: ["International experience", "Skill development", "Networking", "Travel opportunities"],
            deadline: Date().addingTimeInterval(86400 * 30),
            startDate: Date().addingTimeInterval(86400 * 90),
            endDate: Date().addingTimeInterval(86400 * 450),
            location: "Various countries",
            isRemote: false,
            applicationUrl: "https://example.com/un-volunteer",
            tags: ["volunteer", "international", "service", "UN"]
        ))
        
        // Sample bootcamp opportunities
        opportunities.append(Opportunity(
            title: "Lighthouse Labs Web Development Bootcamp",
            type: .bootcamp,
            category: .technology,
            organization: "Lighthouse Labs",
            description: "Intensive 12-week program to become a full-stack web developer.",
            requirements: ["Basic computer skills", "Commitment to learning", "No prior coding experience required"],
            benefits: ["Job placement support", "Industry connections", "Portfolio development", "Career coaching"],
            deadline: Date().addingTimeInterval(86400 * 15),
            startDate: Date().addingTimeInterval(86400 * 30),
            endDate: Date().addingTimeInterval(86400 * 114),
            location: "Toronto, ON",
            isRemote: true,
            amount: 12000,
            applicationUrl: "https://example.com/lighthouse-bootcamp",
            tags: ["coding", "bootcamp", "web-development", "career-change"]
        ))
        
        // Sample exchange program opportunities
        opportunities.append(Opportunity(
            title: "Globalink Research Exchange",
            type: .exchange,
            category: .research,
            organization: "Mitacs",
            description: "Research exchange program connecting Canadian students with international institutions.",
            requirements: ["Undergraduate student", "Strong academic record", "Research interest", "University nomination"],
            benefits: ["International research experience", "Funding support", "Academic credit", "Cultural exchange"],
            deadline: Date().addingTimeInterval(86400 * 60),
            startDate: Date().addingTimeInterval(86400 * 120),
            endDate: Date().addingTimeInterval(86400 * 180),
            location: "Various countries",
            isRemote: false,
            stipend: 20.0,
            applicationUrl: "https://example.com/globalink",
            tags: ["research", "exchange", "international", "academic"]
        ))
        
        // 🇨🇦 Canada Service Corps Programs
        opportunities.append(Opportunity(
            title: "Sail2Success! Canada Service Corps",
            type: .volunteer,
            category: .communityService,
            organization: "Canada Service Corps",
            description: "Tall-ship day sails & overnight voyages, shoreline clean-ups, workshops on Indigenous reconciliation, sail-training skills, project-management.",
            requirements: ["Ages 12-30", "Canadian citizens/PR/refugee youth", "120h minimum commitment", "Flexible schedule"],
            benefits: ["CSC completion certificate", "Marine-skills logbook", "Travel bursaries when sailing", "Indigenous reconciliation workshops"],
            deadline: Date().addingTimeInterval(86400 * 300), // Feb 28, 2026
            startDate: Date().addingTimeInterval(86400 * 15), // Apr 9, 2025
            endDate: Date().addingTimeInterval(86400 * 300),
            location: "Hybrid (online + on-board sessions in ports across Canada)",
            isRemote: true,
            applicationUrl: "https://canada.ca/service-corps",
            tags: ["sailing", "environmental", "indigenous", "leadership", "marine"]
        ))
        
        opportunities.append(Opportunity(
            title: "Youth Service CivicCorps (CivicAction)",
            type: .volunteer,
            category: .socialJustice,
            organization: "CivicAction",
            description: "Leadership boot-camp, team civic project, placement in local NGO/municipality with résumé coaching and alumni network.",
            requirements: ["Ages 18-30", "Living in GTA/Hamilton", "120h over ~12 weeks", "Training + placement commitment"],
            benefits: ["Leadership boot-camp", "Team civic project", "NGO/municipality placement", "Résumé coaching", "Alumni network", "Transit/child-care reimbursements"],
            deadline: Date().addingTimeInterval(86400 * 30), // Jun 29, 2025
            startDate: Date().addingTimeInterval(86400 * 60), // Aug 2025
            endDate: Date().addingTimeInterval(86400 * 150), // Jan 2026
            location: "GTA/Hamilton",
            isRemote: false,
            applicationUrl: "https://charityvillage.com/civiccorps",
            tags: ["leadership", "civic", "community", "networking"]
        ))
        
        // 🌍 WUSC Campus Local Committees
        opportunities.append(Opportunity(
            title: "WUSC Campus Local Committees",
            type: .volunteer,
            category: .socialJustice,
            organization: "World University Service of Canada (WUSC)",
            description: "Sponsor and mentor refugee students through the Student Refugee Program; run awareness campaigns; fund-raise on campus.",
            requirements: ["2-4h/week during term", "Leadership commitment", "Campus involvement", "Passion for refugee support"],
            benefits: ["Leadership retreats", "Training provided", "No fees", "Refugee student mentorship", "Awareness campaign experience"],
            deadline: nil, // Rolling
            startDate: Date().addingTimeInterval(86400 * 30), // Fall term
            endDate: Date().addingTimeInterval(86400 * 120), // End of term
            location: "90+ universities, colleges & CEGEPs nationwide",
            isRemote: false,
            applicationUrl: "https://wusc.ca/campus-committees",
            tags: ["refugee", "mentorship", "advocacy", "campus"]
        ))
        
        // 🌱 Environmental & Conservation Volunteers
        opportunities.append(Opportunity(
            title: "Engineers Without Borders Canada (EWB)",
            type: .volunteer,
            category: .environment,
            organization: "Engineers Without Borders Canada",
            description: "Advocacy campaigns, school outreach, annual national conference, internship in sub-Saharan Africa.",
            requirements: ["18+ for campus chapters", "19-30 for Junior Fellowship", "Weekly meetings commitment", "Passion for global development"],
            benefits: ["Conference in January", "Overseas placements 4 months (funded)", "Advocacy experience", "School outreach opportunities"],
            deadline: Date().addingTimeInterval(86400 * 365), // Jan 2026 for Junior Fellowship
            startDate: Date().addingTimeInterval(86400 * 30), // September for campus chapters
            endDate: Date().addingTimeInterval(86400 * 120),
            location: "Campus chapters nationwide + overseas placements",
            isRemote: false,
            applicationUrl: "https://ewb.ca",
            tags: ["engineering", "global development", "advocacy", "overseas"]
        ))
        
        opportunities.append(Opportunity(
            title: "Canadian Wildlife Federation – WILD Outside",
            type: .volunteer,
            category: .environment,
            organization: "Canadian Wildlife Federation",
            description: "Local conservation projects, outdoor trips, can count toward high-school volunteer hours.",
            requirements: ["Ages 15-18", "Nationwide participation", "Target 120 service hours per year", "Passion for wildlife"],
            benefits: ["Free program", "High-school volunteer hours", "Local conservation projects", "Outdoor trips", "Wildlife education"],
            deadline: nil, // Year-round intakes
            startDate: Date(),
            endDate: Date().addingTimeInterval(86400 * 365),
            location: "Nationwide",
            isRemote: false,
            applicationUrl: "https://candidate.cwf-fcf.org/wild-outside",
            tags: ["wildlife", "conservation", "outdoors", "youth"]
        ))
        
        opportunities.append(Opportunity(
            title: "Canadian Conservation Corps (CCC)",
            type: .volunteer,
            category: .environment,
            organization: "Canadian Wildlife Federation",
            description: "8-month journey including wilderness expedition, field placement, and community project.",
            requirements: ["Ages 18-30", "Canadian citizens/PR/refugees", "8-month commitment", "Adventure-ready"],
            benefits: ["First-aid certification", "OCC Field Leader-1", "CWF certifications", "Adventure travel", "Paid fieldwork", "Travel, gear & stipend covered"],
            deadline: Date().addingTimeInterval(86400 * 60), // Winter 2025 cohort
            startDate: Date().addingTimeInterval(86400 * 90), // Winter 2025
            endDate: Date().addingTimeInterval(86400 * 330), // 8 months
            location: "Canada-wide",
            isRemote: false,
            applicationUrl: "https://cwf-fcf.org/ccc",
            tags: ["conservation", "wilderness", "adventure", "certification"]
        ))
        
        opportunities.append(Opportunity(
            title: "Junior Forest Wardens",
            type: .volunteer,
            category: .environment,
            organization: "Junior Forest Wardens",
            description: "Four age divisions, red-shirt uniform, ecology/forestry/bushcraft badges; family-based program.",
            requirements: ["Ages 6-18", "Parents join too", "Weekly meetings Sept-June", "Modest annual dues", "Gear required"],
            benefits: ["Ecology/forestry/bushcraft badges", "Family-based program", "Red-shirt uniform", "Active in BC, AB, SK, NL"],
            deadline: Date().addingTimeInterval(86400 * 30), // September start
            startDate: Date().addingTimeInterval(86400 * 30), // September
            endDate: Date().addingTimeInterval(86400 * 270), // June
            location: "BC, AB, SK, NL",
            isRemote: false,
            applicationUrl: "https://sites.google.com/juniorforestwardens",
            tags: ["forestry", "ecology", "family", "outdoors"]
        ))
        
        opportunities.append(Opportunity(
            title: "Outdoor Council of Canada – Field Leader (Calgary)",
            type: .volunteer,
            category: .environment,
            organization: "Outdoor Council of Canada",
            description: "Nationally-recognized hiking-leader certification; prerequisite for CCC Stage 1; qualifies for Parks Canada permits.",
            requirements: ["18+", "2-day course commitment", "$250 incl. 1-yr OCC membership", "Calgary location"],
            benefits: ["Nationally-recognized certification", "Prerequisite for CCC Stage 1", "Parks Canada permits", "OCC membership"],
            deadline: Date().addingTimeInterval(86400 * 45), // May 20-23, 2025
            startDate: Date().addingTimeInterval(86400 * 45), // May 20-23, 2025
            endDate: Date().addingTimeInterval(86400 * 47), // May 23, 2025
            location: "Calgary",
            isRemote: false,
            amount: 250,
            applicationUrl: "https://outdoorcouncil.ca",
            tags: ["hiking", "leadership", "certification", "outdoors"]
        ))
        
        // 👥 Community & Social Service
        opportunities.append(Opportunity(
            title: "Youth & Philanthropy Initiative (YPI)",
            type: .volunteer,
            category: .communityService,
            organization: "Youth & Philanthropy Initiative",
            description: "Classroom project with charity visit; winning team directs $5,000 grant to local charity.",
            requirements: ["Grade 9-12", "Partner high-schools", "Classroom project (8-10 lessons)", "Charity visit"],
            benefits: ["Public-speaking skills", "Grant-writing experience", "Local-charity networking", "$5,000 grant for winning team", "$20M+ granted since 2003"],
            deadline: Date().addingTimeInterval(86400 * 30), // Sept 10 for Fall
            startDate: Date().addingTimeInterval(86400 * 30), // Fall term
            endDate: Date().addingTimeInterval(86400 * 90), // End of term
            location: "Partner high-schools nationwide",
            isRemote: false,
            applicationUrl: "https://goypi.ca",
            tags: ["philanthropy", "grant-writing", "public-speaking", "charity"]
        ))
        
        opportunities.append(Opportunity(
            title: "Helping Hands (Ontario)",
            type: .volunteer,
            category: .communityService,
            organization: "Helping Hands",
            description: "Matches students to virtual or in-person roles fulfilling 40-hour OSSD requirement with barrier-free supports.",
            requirements: ["Youth 13-29", "Across Ontario", "Flexible commitment", "Free 1-on-1 matching"],
            benefits: ["Résumé help", "Barrier-free supports", "OSSD requirement fulfillment", "Virtual or in-person roles"],
            deadline: nil, // Rolling signup
            startDate: Date(),
            endDate: Date().addingTimeInterval(86400 * 365),
            location: "Ontario",
            isRemote: true,
            applicationUrl: "https://helpinghandsapp.com",
            tags: ["community", "matching", "flexible", "support"]
        ))
        
        // 🏥 Health & Mentorship
        opportunities.append(Opportunity(
            title: "Starts With One Canada – Community Tutor",
            type: .volunteer,
            category: .healthcare,
            organization: "Starts With One Canada",
            description: "1-on-1 virtual tutoring for newcomer & low-income students; lesson prep & progress logs.",
            requirements: ["Grade 10+ volunteers", "GTA region (remote)", "1-2h/week", "Min 3 months", "Lesson prep commitment"],
            benefits: ["Quarterly PD sessions", "Equity-education training", "Reference letter", "Virtual tutoring experience"],
            deadline: nil, // Rolling
            startDate: Date(),
            endDate: Date().addingTimeInterval(86400 * 90), // 3 months minimum
            location: "GTA (remote)",
            isRemote: true,
            applicationUrl: "https://swocanada.org",
            tags: ["tutoring", "education", "equity", "virtual"]
        ))
        
        opportunities.append(Opportunity(
            title: "Learning Buddies Network (BC)",
            type: .volunteer,
            category: .communityService,
            organization: "Learning Buddies Network",
            description: "Literacy/math mentor training, CRC provided, 700+ youth mentors annually.",
            requirements: ["HS & university mentors", "2 sessions/week", "Online or centres in Vancouver & Surrey", "Summer 2025 commitment"],
            benefits: ["Literacy/math mentor training", "CRC provided", "700+ youth mentors annually", "Online or in-person"],
            deadline: Date().addingTimeInterval(86400 * 30), // Summer 2025 apps
            startDate: Date().addingTimeInterval(86400 * 90), // Summer 2025
            endDate: Date().addingTimeInterval(86400 * 150), // End of summer
            location: "Vancouver & Surrey, BC",
            isRemote: true,
            applicationUrl: "https://learningbuddiesnetwork.com",
            tags: ["mentoring", "literacy", "math", "youth"]
        ))
        
        opportunities.append(Opportunity(
            title: "CALMS – Latin Medical Student Mentorship",
            type: .volunteer,
            category: .healthcare,
            organization: "CALMS",
            description: "Mock interviews, health-media outreach, radio segments; remote mentoring for Latinx pre-med & med students.",
            requirements: ["Latinx pre-med & med students", "Canada-wide", "Rolling applications", "Remote commitment"],
            benefits: ["Faculty mentors at 8 med schools", "Reference letters", "Mock interviews", "Health-media outreach"],
            deadline: nil, // Rolling
            startDate: Date(),
            endDate: Date().addingTimeInterval(86400 * 365),
            location: "Canada-wide (remote)",
            isRemote: true,
            applicationUrl: "https://forms.google.com/calms-mentorship",
            tags: ["medical", "mentorship", "latinx", "remote"]
        ))
        
        // 🧠 Youth Leadership & Civic Action
        opportunities.append(Opportunity(
            title: "RISE (Apathy is Boring)",
            type: .volunteer,
            category: .socialJustice,
            organization: "Apathy is Boring",
            description: "All-expenses retreat, weekly meals, civic-project micro-budget, alumni network.",
            requirements: ["Ages 18-30", "8 hub cities including Halifax", "120h (3h hub + 3h tasks weekly)", "Aug 11 – Nov 22, 2025"],
            benefits: ["All-expenses retreat", "Weekly meals", "Civic-project micro-budget", "Alumni network", "Leadership development"],
            deadline: Date().addingTimeInterval(86400 * 30), // Spring applications
            startDate: Date().addingTimeInterval(86400 * 60), // Aug 11, 2025
            endDate: Date().addingTimeInterval(86400 * 150), // Nov 22, 2025
            location: "8 hub cities including Halifax",
            isRemote: false,
            applicationUrl: "https://apathyisboring.com/rise",
            tags: ["leadership", "civic", "retreat", "networking"]
        ))
        
        opportunities.append(Opportunity(
            title: "C3 Canada CyberSTEAM Challenge – Volunteer Director",
            type: .volunteer,
            category: .technology,
            organization: "C3 Canada",
            description: "National STEAM competition logistics; leadership title, media exposure, reference letter.",
            requirements: ["Post-secondary students", "Remote, Canada-wide", "2-4h/week", "Oct 2024 – Apr 2025"],
            benefits: ["Leadership title", "Media exposure", "Reference letter", "National STEAM competition experience"],
            deadline: Date().addingTimeInterval(86400 * 30), // Rolling applications
            startDate: Date().addingTimeInterval(86400 * 30), // Oct 2024
            endDate: Date().addingTimeInterval(86400 * 180), // Apr 2025
            location: "Canada-wide (remote)",
            isRemote: true,
            applicationUrl: "https://volunteerconnector.org/c3",
            tags: ["steam", "technology", "leadership", "remote"]
        ))
        
        // --- Added: Major Canadian & International Internships ---
        opportunities.append(Opportunity(
            title: "Future Tech Summer Internship",
            type: .internship,
            category: .technology,
            organization: "Nokia",
            description: "In-person sprint in Ottawa working with Nokia engineers on real technical challenges (IoT, 5G), capped with a pitch to Bell Labs mentors.",
            requirements: ["Canadian high-school & 1st/2nd-year STEM post-secondary students"],
            benefits: ["Paid (~$17–18/hr)", "Travel bursary", "Mentorship via industry pros"],
            deadline: nil, // Next applications ~Jan 2026
            startDate: nil, // ~Jul 2025
            endDate: nil, // ~Aug 2025
            location: "Ottawa, ON",
            isRemote: false,
            stipend: 17.5,
            website: "https://nokia.com",
            tags: ["internship", "technology", "engineering", "iot", "5g", "canada", "nokia"]
        ))
        opportunities.append(Opportunity(
            title: "Google STEP (Student Training in Engineering Program)",
            type: .internship,
            category: .technology,
            organization: "Google",
            description: "Pair-programming on production code, daily mentorship, languages such as Python, Java, C++ — all within a large-team environment.",
            requirements: ["1st–2nd-year CS/Engineering undergrads (Canada or broader)"],
            benefits: ["Fully paid", "Housing & relocation support"],
            deadline: Date(timeIntervalSince1970: 1729814400), // Oct 25, 2024
            startDate: Date(timeIntervalSince1970: 1751241600), // Jun 30, 2025
            endDate: Date(timeIntervalSince1970: 1758838400), // Sep 26, 2025
            location: "Canada (various)",
            isRemote: false,
            website: "https://sing-canada.ca",
            tags: ["internship", "google", "step", "engineering", "canada", "python", "java", "c++"]
        ))
        opportunities.append(Opportunity(
            title: "Explore Microsoft",
            type: .internship,
            category: .technology,
            organization: "Microsoft",
            description: "Rotational experience (Design → Build → Quality) in small 'pod' teams; perfect sampler of Microsoft engineering roles.",
            requirements: ["1st–2nd-year CS undergraduates (Canadian passport holders okay for Redmond)"],
            benefits: ["Paid internship", "Housing", "Azure credits"],
            deadline: Date(timeIntervalSince1970: 1751328000), // Oct 31, 2025 (apps open Aug–Oct 2025)
            startDate: Date(timeIntervalSince1970: 1772563200), // May 2026
            endDate: nil,
            location: "Canada or Redmond, WA",
            isRemote: false,
            website: "https://careers.microsoft.com",
            tags: ["internship", "microsoft", "explore", "engineering", "canada", "rotation"]
        ))
        opportunities.append(Opportunity(
            title: "Extreme Blue – IBM",
            type: .internship,
            category: .technology,
            organization: "IBM",
            description: "Work in a four-person 'startup' squad (3 tech, 1 PM) on an MVP solving a complex tech/business challenge. Potential to file patents, high-level demo day to IBM execs.",
            requirements: ["Junior/senior STEM undergrads, MSc, or MBA with leadership aspirations"],
            benefits: ["Competitive tech pay", "Potential to file patents", "Demo day to IBM execs"],
            deadline: Date(timeIntervalSince1970: 1752019200), // Nov 8, 2025 (apps open Sept 2025)
            startDate: Date(timeIntervalSince1970: 1772659200), // May 2026
            endDate: Date(timeIntervalSince1970: 1780512000), // Aug 2026
            location: "Canada (various)",
            isRemote: false,
            website: "https://ibm.com",
            tags: ["internship", "ibm", "extreme blue", "startup", "mvp", "patents", "leadership"]
        ))
        opportunities.append(Opportunity(
            title: "Amplify Innovation Program – RBC",
            type: .internship,
            category: .business,
            organization: "RBC",
            description: "Small innovation teams work on real-world 'bold challenges' and pitch outcomes to RBC leadership at Demo Day.",
            requirements: ["Canadian undergrad/grad students in CS, Data, Business"],
            benefits: ["Paid", "Downtown Toronto housing subsidy", "Cross-country hackathon trip"],
            deadline: Date(timeIntervalSince1970: 1752019200), // Aug 2025 (apps open)
            startDate: Date(timeIntervalSince1970: 1770835200), // May 12, 2026
            endDate: Date(timeIntervalSince1970: 1782931200), // Aug 29, 2026
            location: "Toronto, ON",
            isRemote: false,
            website: "https://genomealberta.ca",
            tags: ["internship", "rbc", "amplify", "innovation", "business", "hackathon"]
        ))
        opportunities.append(Opportunity(
            title: "Mitacs Business Strategy Internship (BSI)",
            type: .internship,
            category: .business,
            organization: "Mitacs",
            description: "Students co-design projects with companies/nonprofits to solve real business problems—backed by Mitacs EDGE professional development.",
            requirements: ["College/university students or recent grads (<2 years), any discipline"],
            benefits: ["4-month placements (rolling intake)", "$10k stipend or $15k for project + stipend"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada (various)",
            isRemote: true,
            amount: 10000,
            website: "https://mitacs.ca",
            tags: ["internship", "mitacs", "business", "strategy", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "RISE–Globalink Research Internship (Canada→Germany)",
            type: .internship,
            category: .research,
            organization: "DAAD / Mitacs",
            description: "Hands-on lab research in Germany, visa/travel managed, real international R&D experience.",
            requirements: ["Canadian undergrads (Biology, Chemistry, CS, Engineering, Physics, Earth Sciences) after Year 2"],
            benefits: ["DAAD stipend", "Airfare", "Housing support via Mitacs"],
            deadline: Date(timeIntervalSince1970: 1764547200), // Dec 2025 (apps open Oct–Dec 2025)
            startDate: Date(timeIntervalSince1970: 1772659200), // May 2026
            endDate: Date(timeIntervalSince1970: 1780512000), // Aug 2026
            location: "Germany",
            isRemote: false,
            website: "https://research.ucalgary.ca/RISE-Globalink",
            tags: ["internship", "research", "germany", "mitacs", "daad", "international"]
        ))
        opportunities.append(Opportunity(
            title: "SING Canada Indigenous Genomics Internship",
            type: .internship,
            category: .stem,
            organization: "SING Canada",
            description: "Integrates wet-lab techniques, bioethics, Indigenous knowledge, and genomics capacity building. 1-week fully-funded residential workshop in Sweden.",
            requirements: ["First Nations, Inuit & Métis students (undergrad/grad/post-doc/community fellows)"],
            benefits: ["Fully covered—travel, lodge, meals, equity-focused learning"],
            deadline: Date(timeIntervalSince1970: 1755024000), // Aug 12, 2025
            startDate: Date(timeIntervalSince1970: 1755024000), // Aug 12, 2025
            endDate: Date(timeIntervalSince1970: 1755619200), // Aug 16, 2025
            location: "Sweden",
            isRemote: false,
            website: "https://sing-canada.ca",
            tags: ["internship", "indigenous", "genomics", "canada", "sweden", "stem"]
        ))
        
        // --- Added: More Canadian & Environmental Internships ---
        opportunities.append(Opportunity(
            title: "Richard E. Azuma Summer Fellowship – TRIUMF (Vancouver)",
            type: .internship,
            category: .stem,
            organization: "TRIUMF",
            description: "Pick one of TRIUMF's rare-isotope or accelerator projects; publishable research & mentorship from national-lab scientists.",
            requirements: ["Canadian citizens/PR in the summer before final undergrad year at a TRIUMF member university"],
            benefits: ["Salary (~$22/hr)", "Flight", "1-week TRIUMF House stay", "Future $5k grad-school bonus"],
            deadline: dateFormatter.date(from: "January 10, 2025"),
            startDate: dateFormatter.date(from: "May 1, 2025"),
            endDate: dateFormatter.date(from: "August 31, 2025"),
            location: "Vancouver, BC",
            isRemote: false,
            stipend: 22.0,
            website: "https://www.triumf.ca/azuma-fellowship",
            tags: ["internship", "triumf", "physics", "research", "canada", "vancouver"]
        ))
        opportunities.append(Opportunity(
            title: "YES! (Young Engineers & Scientists) Fellowship – TRIUMF",
            type: .internship,
            category: .stem,
            organization: "TRIUMF",
            description: "Live in a big-science lab; hands-on detectors & data, perfect bridge from HS→uni research.",
            requirements: ["BC high-school grads entering 1st-year STEM"],
            benefits: ["~$4,000 stipend", "Travel/housing if outside Metro-Van"],
            deadline: dateFormatter.date(from: "April 7, 2025"),
            startDate: dateFormatter.date(from: "July 1, 2025"),
            endDate: dateFormatter.date(from: "August 15, 2025"),
            location: "Vancouver, BC",
            isRemote: false,
            amount: 4000,
            website: "https://www.triumf.ca/yes-fellowship",
            tags: ["internship", "triumf", "stem", "high school", "research", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Blue Futures Pathways Internship – SOI Foundation",
            type: .internship,
            category: .environment,
            organization: "SOI Foundation",
            description: "Work on ocean-tech, fisheries, coastal-climate or blue-finance projects with NGOs & industry.",
            requirements: ["Canadians 18–35 keen on the Sustainable Blue Economy"],
            benefits: ["Paid placement", "Free online course", "Mentorship", "Career coaching"],
            deadline: nil,
            startDate: dateFormatter.date(from: "June 1, 2025"),
            endDate: dateFormatter.date(from: "September 30, 2025"),
            location: "Canada (various)",
            isRemote: true,
            website: "https://soifoundation.org",
            tags: ["internship", "blue economy", "ocean", "environment", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Green Jobs Wage-Match – Project Learning Tree Canada",
            type: .internship,
            category: .environment,
            organization: "Project Learning Tree Canada",
            description: "Forest-tech, parks, conservation & eco-tourism roles Canada-wide; résumé booster certs.",
            requirements: ["Youth 15–30; any STEM/business/enviro discipline"],
            benefits: ["Wage subsidy pays 50–80% so most placements are paid"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada-wide",
            isRemote: false,
            website: "https://pltcanada.org/en/green-jobs/",
            tags: ["internship", "green jobs", "conservation", "environment", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Science Horizons Youth Internship – ECO Canada",
            type: .internship,
            category: .environment,
            organization: "ECO Canada",
            description: "Employers add climate-tech jobs; interns get free training + national peer network.",
            requirements: ["Post-secondary grads 15–30 in STEM/enviro"],
            benefits: ["Up to $25k wage subsidy ⇒ paid internships (~$40k annual)", "Free training", "National peer network"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada-wide",
            isRemote: false,
            website: "https://eco.ca/careerfunding/",
            tags: ["internship", "eco canada", "science horizons", "environment", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "First Nations & Inuit Summer Work Experience (ISC)",
            type: .internship,
            category: .business,
            organization: "Indigenous Services Canada (ISC)",
            description: "Community, gov't or NGO hosts; builds skills + income toward tuition.",
            requirements: ["First Nations & Inuit secondary / post-secondary students"],
            benefits: ["Wage subsidies flow to host orgs → paid placements"],
            deadline: dateFormatter.date(from: "March 7, 2025"),
            startDate: dateFormatter.date(from: "May 1, 2025"),
            endDate: dateFormatter.date(from: "August 31, 2025"),
            location: "Canada (various)",
            isRemote: false,
            website: "https://www.sac-isc.gc.ca/eng/1100100033679/1531406248822",
            tags: ["internship", "indigenous", "community", "canada", "summer"]
        ))
        opportunities.append(Opportunity(
            title: "Council of the Federation Youth Internship (Ottawa)",
            type: .internship,
            category: .business,
            organization: "Council of the Federation",
            description: "Travel with Premiers' secretariat, plan national meetings, deep dive into inter-governmental policy.",
            requirements: ["Recent grads ≤ 25 yrs; bilingual (EN/FR)"],
            benefits: ["$50k salary", "Up-to $3k relocation"],
            deadline: dateFormatter.date(from: "February 27, 2025"),
            startDate: dateFormatter.date(from: "July 1, 2025"),
            endDate: dateFormatter.date(from: "June 30, 2026"),
            location: "Ottawa, ON",
            isRemote: false,
            amount: 50000,
            website: "https://canadaspremiers.ca/youth-internship/",
            tags: ["internship", "federation", "government", "ottawa", "bilingual"]
        ))
        opportunities.append(Opportunity(
            title: "Youth Climate Corps – Wildsight (West Kootenay, BC)",
            type: .internship,
            category: .environment,
            organization: "Wildsight",
            description: "Tackle wildfire-risk, retrofits, invasive plants; get climate-action & leadership training.",
            requirements: ["Ages 17–30, outdoor-ready"],
            benefits: ["$21.82/hr + certs (OFA-1, chainsaw, wildfire)", "Housing during projects"],
            deadline: nil,
            startDate: dateFormatter.date(from: "April 22, 2025"),
            endDate: dateFormatter.date(from: "August 22, 2025"),
            location: "West Kootenay, BC",
            isRemote: false,
            stipend: 21.82,
            website: "https://wildsight.ca/programs/youthclimatecorps/",
            tags: ["internship", "climate", "wildfire", "environment", "bc"]
        ))
        opportunities.append(Opportunity(
            title: "Northern Scientific Training Program – POLAR",
            type: .internship,
            category: .research,
            organization: "POLAR",
            description: "Fund your own Arctic field season—any discipline from geology to Inuit Qaujimajatuqangit.",
            requirements: ["Senior undergrad & grad students doing Arctic research"],
            benefits: ["Avg $6k travel grant for fieldwork north of permafrost line"],
            deadline: dateFormatter.date(from: "December 1, 2024"),
            startDate: nil,
            endDate: nil,
            location: "Arctic Canada",
            isRemote: false,
            amount: 6000,
            website: "https://www.canada.ca/en/polar-knowledge/programs/science-and-technology/northern-scientific-training-program.html",
            tags: ["internship", "arctic", "research", "fieldwork", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Indigenous Student Museum Internship – Royal Alberta Museum",
            type: .internship,
            category: .humanities,
            organization: "Royal Alberta Museum",
            description: "Curation, collections, and Indigenous-studies projects; respond to TRC 'Museums & Peoples' calls.",
            requirements: ["First Nations, Métis, Inuit students (any field)"],
            benefits: ["$20–21/hr + museology workshops"],
            deadline: nil,
            startDate: dateFormatter.date(from: "January 1, 2025"),
            endDate: dateFormatter.date(from: "April 30, 2025"),
            location: "Edmonton, AB",
            isRemote: false,
            stipend: 20.5,
            website: "https://frams.ca/indigenous-internship/",
            tags: ["internship", "museum", "indigenous", "alberta", "humanities"]
        ))
        opportunities.append(Opportunity(
            title: "Eco-Internships Youth Support Program",
            type: .internship,
            category: .environment,
            organization: "Eco-Internships",
            description: "Pair with grassroots NGOs, design & run your own climate-action project.",
            requirements: ["Youth 18–30 with passion for environment"],
            benefits: ["Subsidised training & mentorship", "Some placements paid via wage grants"],
            deadline: nil,
            startDate: dateFormatter.date(from: "January 1, 2025"),
            endDate: dateFormatter.date(from: "September 30, 2025"),
            location: "Canada (various)",
            isRemote: true,
            website: "https://ecointernships.ca",
            tags: ["internship", "eco", "climate", "environment", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "OFAH / Fitzsimons Conservation Internship (ON)",
            type: .internship,
            category: .environment,
            organization: "Ontario Federation of Anglers and Hunters (OFAH)",
            description: "Work on policy, hatcheries, Atlantic-salmon restoration, invasive-species outreach with Ontario's largest fish-&-wildlife NGO.",
            requirements: ["Recent grads or students in bio/enviro"],
            benefits: ["$20–21/hr, 35 h/wk"],
            deadline: dateFormatter.date(from: "November 6, 2024"),
            startDate: dateFormatter.date(from: "January 1, 2025"),
            endDate: dateFormatter.date(from: "August 31, 2025"),
            location: "Ontario",
            isRemote: false,
            stipend: 20.5,
            website: "https://www.ofah.org/fitzsimons-internship/",
            tags: ["internship", "conservation", "ofah", "ontario", "environment"]
        ))
        
        // --- Added: Even More Major Internships ---
        opportunities.append(Opportunity(
            title: "Cansbridge Fellowship — Asia Internship + $10K",
            type: .internship,
            category: .business,
            organization: "Cansbridge Fellowship",
            description: "Self-organize a summer internship anywhere in Asia; past fellows built medical devices in Bangladesh & PM-ed apps in Vietnam. Includes $10,000 scholarship, flights, 3-week entrepreneurship boot-camp & lifelong alumni network.",
            requirements: ["Undergrad students at Canadian universities, any major"],
            benefits: ["$10,000 scholarship", "Flights", "3-week entrepreneurship boot-camp", "Lifelong alumni network"],
            deadline: dateFormatter.date(from: "October 17, 2025"),
            startDate: dateFormatter.date(from: "May 1, 2026"),
            endDate: dateFormatter.date(from: "August 31, 2026"),
            location: "Asia (self-organized)",
            isRemote: true,
            amount: 10000,
            website: "https://cansbridgefellowship.com",
            tags: ["internship", "asia", "entrepreneurship", "business", "canada", "fellowship"]
        ))
        opportunities.append(Opportunity(
            title: "Clean Leadership Summer Internship — Clean Foundation (NS)",
            type: .internship,
            category: .environment,
            organization: "Clean Foundation",
            description: "Hands-on climate & clean-economy roles (coastal restoration, EV outreach, green buildings) across Nova Scotia. $16–18/hr (50–80% wage matched) + leadership training & mentorship.",
            requirements: ["Youth 15–30 in any discipline; priority to Black, Indigenous & rural Nova Scotians"],
            benefits: ["$16–18/hr (50–80% wage matched)", "Leadership training", "Mentorship"],
            deadline: dateFormatter.date(from: "January 21, 2025"),
            startDate: dateFormatter.date(from: "May 1, 2025"),
            endDate: dateFormatter.date(from: "August 31, 2025"),
            location: "Nova Scotia",
            isRemote: false,
            stipend: 17.0,
            website: "https://cleanfoundation.ca",
            tags: ["internship", "clean foundation", "climate", "environment", "nova scotia"]
        ))
        opportunities.append(Opportunity(
            title: "Ocean Pathways — Ocean Wise",
            type: .internship,
            category: .environment,
            organization: "Ocean Wise",
            description: "Full-time placement with marine labs, Indigenous Guardians, or ocean-tech firms; career coaching & Blue Economy network. Stipend + travel/gear support + coaching.",
            requirements: ["Youth 19–30 across Canada, any background"],
            benefits: ["Stipend", "Travel/gear support", "Coaching", "Blue Economy network"],
            deadline: nil,
            startDate: dateFormatter.date(from: "February 1, 2025"),
            endDate: dateFormatter.date(from: "April 30, 2025"),
            location: "Canada (various)",
            isRemote: false,
            website: "https://ocean.org",
            tags: ["internship", "ocean wise", "marine", "environment", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Youth to Sea — Ocean Wise",
            type: .internship,
            category: .environment,
            organization: "Ocean Wise",
            description: "Monthly excursions, skill-builders, and a team ocean-service project that counts for school volunteer hours. Free; 120 volunteer-h certificate, expedition days, outdoor gear.",
            requirements: ["Teens 15–18 in Halifax, Montréal, Ottawa, Vancouver, Victoria"],
            benefits: ["Free", "120 volunteer-h certificate", "Expedition days", "Outdoor gear"],
            deadline: dateFormatter.date(from: "September 30, 2025"),
            startDate: dateFormatter.date(from: "December 1, 2024"),
            endDate: dateFormatter.date(from: "July 31, 2025"),
            location: "Halifax, Montréal, Ottawa, Vancouver, Victoria",
            isRemote: false,
            website: "https://ocean.org",
            tags: ["internship", "ocean wise", "youth", "environment", "volunteer"]
        ))
        opportunities.append(Opportunity(
            title: "Venture for Canada Internship Program (Startup SWPP)",
            type: .internship,
            category: .business,
            organization: "Venture for Canada",
            description: "Work at a high-growth startup or SMB; VFC boot-camp + alumni community (6,000+ grads). Employer wage subsidy up to $7k, paid roles + 20h entrepreneurship training.",
            requirements: ["College / uni students — any major, anywhere in Canada"],
            benefits: ["Employer wage subsidy up to $7k", "Paid roles", "20h entrepreneurship training", "Alumni community"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada (various)",
            isRemote: true,
            amount: 7000,
            website: "https://ventureforcanada.ca",
            tags: ["internship", "venture for canada", "startup", "business", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Parliamentary Internship Programme (House of Commons)",
            type: .internship,
            category: .business,
            organization: "House of Commons",
            description: "Work half the year for a government MP & half for an opposition MP; study tours to Washington, Brussels & Nunavut. $35,000 scholarship + U Ottawa grad certificate.",
            requirements: ["Recent grads < 35 yrs, any field"],
            benefits: ["$35,000 scholarship", "U Ottawa grad certificate", "Study tours"],
            deadline: dateFormatter.date(from: "December 31, 2025"),
            startDate: dateFormatter.date(from: "September 1, 2026"),
            endDate: dateFormatter.date(from: "June 30, 2027"),
            location: "Ottawa, ON",
            isRemote: false,
            amount: 35000,
            website: "https://pip-psp.org",
            tags: ["internship", "parliament", "government", "ottawa", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Pathy Foundation Fellowship",
            type: .internship,
            category: .socialJustice,
            organization: "Pathy Foundation",
            description: "Launch your own community-change initiative for 12 months with coaching & $ funds to execute. Up to $50,000 living + project budget, Coady Institute training.",
            requirements: ["Final-year undergrads (any discipline) at 12 partner universities"],
            benefits: ["Up to $50,000 living + project budget", "Coady Institute training", "Coaching"],
            deadline: dateFormatter.date(from: "December 15, 2024"),
            startDate: dateFormatter.date(from: "September 1, 2025"),
            endDate: dateFormatter.date(from: "August 31, 2026"),
            location: "Canada (12 partner universities)",
            isRemote: true,
            amount: 50000,
            website: "https://pathyfellowship.com",
            tags: ["internship", "fellowship", "community", "social justice", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Amazon JumpStart Apprenticeship",
            type: .internship,
            category: .technology,
            organization: "Amazon",
            description: "Work 8–12 h/week inside AWS teams while still in school; graduate with substantial résumé & references. Hourly pay, laptop, tech mentors.",
            requirements: ["High-school students (grades 10–12) in historically excluded communities"],
            benefits: ["Hourly pay", "Laptop", "Tech mentors"],
            deadline: dateFormatter.date(from: "September 1, 2025"),
            startDate: dateFormatter.date(from: "September 15, 2025"),
            endDate: dateFormatter.date(from: "June 30, 2027"),
            location: "Canada (remote/various)",
            isRemote: true,
            website: "https://amazongirlstechseries.com",
            tags: ["internship", "amazon", "apprenticeship", "technology", "aws", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Google Cloud Technical Residency (CTR)",
            type: .internship,
            category: .technology,
            organization: "Google",
            description: "Intensive training → rotations (Customer Eng, Product Infra, Solutions); pipeline to full-time Cloud Engineer roles. Full Google salary, relocation, rotations across 3 Cloud teams.",
            requirements: ["Final-year STEM undergrads / new grads (Canada eligible)"],
            benefits: ["Full Google salary", "Relocation", "Rotations across 3 Cloud teams"],
            deadline: dateFormatter.date(from: "January 31, 2025"),
            startDate: dateFormatter.date(from: "August 1, 2025"),
            endDate: dateFormatter.date(from: "May 31, 2026"),
            location: "Canada (various)",
            isRemote: false,
            website: "https://buildyourfuture.withgoogle.com",
            tags: ["internship", "google", "cloud", "technology", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Google DeepMind Student Researcher Program",
            type: .internship,
            category: .research,
            organization: "Google DeepMind",
            description: "Join frontier AI teams on graph neural nets, protein folding, or RL; mentoring from DeepMind scientists. Paid research stipend, publish with Google authors.",
            requirements: ["BS/MS/PhD students in AI/ML; Canadian locations — Waterloo, Toronto, Montréal"],
            benefits: ["Paid research stipend", "Publish with Google authors", "Mentoring from DeepMind scientists"],
            deadline: dateFormatter.date(from: "July 11, 2025"),
            startDate: nil,
            endDate: nil,
            location: "Waterloo, Toronto, Montréal",
            isRemote: false,
            website: "https://deepmind.google",
            tags: ["internship", "deepmind", "ai", "ml", "research", "canada"]
        ))
        
        // --- Added: Vector, AI, Green Jobs, and More Internships ---
        opportunities.append(Opportunity(
            title: "Vector Institute Research Internship (Toronto, ON)",
            type: .internship,
            category: .research,
            organization: "Vector Institute",
            description: "Join a Vector faculty lab on frontier AI (CV, NLP, quantum ML, health AI) & present at institute research day. Paid by supervisor; daily seminars; IMPACT mentorship.",
            requirements: ["2nd-year to PhD students in STEM/AI (Canadian & intl.)"],
            benefits: ["Paid by supervisor", "Daily seminars", "IMPACT mentorship"],
            deadline: dateFormatter.date(from: "January 13, 2026"),
            startDate: dateFormatter.date(from: "May 1, 2026"),
            endDate: dateFormatter.date(from: "August 31, 2026"),
            location: "Toronto, ON",
            isRemote: false,
            website: "https://vectorinstitute.ai",
            tags: ["internship", "vector", "ai", "research", "toronto", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Vector Black & Indigenous AI Internship",
            type: .internship,
            category: .research,
            organization: "Vector Institute",
            description: "Dedicated cohort with cultural supports, career coaching & industry mentor pairings. Fully paid; CIFAR Inclusive-AI top-ups.",
            requirements: ["Self-identified Black or Indigenous undergrads to post-docs"],
            benefits: ["Fully paid", "CIFAR Inclusive-AI top-ups", "Cultural supports", "Career coaching", "Industry mentor pairings"],
            deadline: dateFormatter.date(from: "February 28, 2026"),
            startDate: dateFormatter.date(from: "May 1, 2026"),
            endDate: dateFormatter.date(from: "August 31, 2026"),
            location: "Toronto, ON",
            isRemote: false,
            website: "https://vectorinstitute.ai",
            tags: ["internship", "vector", "ai", "black", "indigenous", "research", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "AI for Public Health (AI4PH) – First Nations Data Sovereignty Internship",
            type: .internship,
            category: .research,
            organization: "AI4PH",
            description: "Co-design ethical AI tools with First Nations partners; publish on Indigenous data governance. Paid 15 h/wk + travel for community visits.",
            requirements: ["Grad students / early-career pros in AI + public-health"],
            benefits: ["Paid 15 h/wk", "Travel for community visits"],
            deadline: dateFormatter.date(from: "June 30, 2025"),
            startDate: dateFormatter.date(from: "June 30, 2025"),
            endDate: dateFormatter.date(from: "December 30, 2025"),
            location: "Canada (remote/various)",
            isRemote: true,
            website: "https://ai4ph-hrtp.ca",
            tags: ["internship", "ai", "public health", "indigenous", "data", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "PICS Climate-Solutions Internship (BC)",
            type: .internship,
            category: .environment,
            organization: "PICS (Pacific Institute for Climate Solutions)",
            description: "Embed with gov/NGO/industry on applied climate-impact projects; present at provincial summit. Salary set by host + PICS training.",
            requirements: ["Senior undergrads & grads in climate/energy"],
            benefits: ["Salary set by host", "PICS training"],
            deadline: dateFormatter.date(from: "March 21, 2025"),
            startDate: dateFormatter.date(from: "May 1, 2025"),
            endDate: dateFormatter.date(from: "September 30, 2025"),
            location: "British Columbia",
            isRemote: false,
            website: "https://pics.uvic.ca",
            tags: ["internship", "climate", "environment", "pics", "bc"]
        ))
        opportunities.append(Opportunity(
            title: "Experience Ventures Micro-Internships (Gov of Canada + Campus hubs)",
            type: .internship,
            category: .business,
            organization: "Experience Ventures / Gov of Canada",
            description: "Tackle a real startup problem in ~8 weeks—perfect for first WIL credit. 60-hr projects each semester; $825 honorarium; 2025-26 apps rolling.",
            requirements: ["Domestic post-secondary students (any major, ON example)"],
            benefits: ["$825 honorarium", "Paid stipend", "Multi-discipline mentors"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada (various)",
            isRemote: true,
            amount: 825,
            website: "https://ontariotechbrilliant.ca",
            tags: ["internship", "micro-internship", "startup", "business", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Student Energy Green-Jobs Program (Nat. Resources Canada)",
            type: .internship,
            category: .environment,
            organization: "Student Energy / Natural Resources Canada",
            description: "Land paid roles (energy analyst, solar tech, ESG) + free sustainability training. Wage subsidy up to $21.5k + $1,000 barrier-removal fund.",
            requirements: ["Youth 18–30, full-time 6–12 mo clean-energy roles"],
            benefits: ["Wage subsidy up to $21.5k", "$1,000 barrier-removal fund", "Free sustainability training"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada (various)",
            isRemote: false,
            amount: 21500,
            website: "https://studentenergy.org",
            tags: ["internship", "green jobs", "energy", "environment", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Clean Foundation Green Jobs Internships (NS-based but Canada-wide)",
            type: .internship,
            category: .environment,
            organization: "Clean Foundation",
            description: "Work in natural-resource, ocean-tech or clean-energy orgs; wrap-around coaching. Paid; Clean Foundation matches up to 80% wages.",
            requirements: ["Youth 15–30, not enrolled in school"],
            benefits: ["Paid", "Clean Foundation matches up to 80% wages", "Wrap-around coaching"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada (various)",
            isRemote: false,
            website: "https://cleanfoundation.ca",
            tags: ["internship", "green jobs", "clean foundation", "environment", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Project Learning Tree Canada – Green Jobs Wage-Match",
            type: .internship,
            category: .environment,
            organization: "Project Learning Tree Canada",
            description: "Field placements in parks, forestry, eco-tourism; earn PLT digital badges. Wage match 50-80% → most roles paid $17-$24/hr.",
            requirements: ["Youth 15–30; forestry/conservation interest"],
            benefits: ["Wage match 50-80%", "Most roles paid $17-$24/hr", "PLT digital badges"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada (various)",
            isRemote: false,
            website: "https://en.wikipedia.org/wiki/Project_Learning_Tree",
            tags: ["internship", "green jobs", "plt", "conservation", "environment", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Young Canada Works (YCW) – Heritage & Arts Internships",
            type: .internship,
            category: .humanities,
            organization: "Young Canada Works / Government of Canada",
            description: "Design exhibits, deliver tours, bilingual programming in galleries across Canada. ~$18/hr federal wage + museum training.",
            requirements: ["College/uni students & grads eligible for YCW pool"],
            benefits: ["~$18/hr federal wage", "Museum training"],
            deadline: dateFormatter.date(from: "February 13, 2025"),
            startDate: dateFormatter.date(from: "May 1, 2025"),
            endDate: dateFormatter.date(from: "September 1, 2025"),
            location: "Canada (various)",
            isRemote: false,
            stipend: 18.0,
            website: "https://jobs.novascotia.ca",
            tags: ["internship", "heritage", "arts", "museum", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Deloitte × Indigenous Youth Roots Policy Analyst Internship",
            type: .internship,
            category: .socialJustice,
            organization: "Deloitte / Indigenous Youth Roots",
            description: "Research Indigenous public-policy issues, publish and brief execs; 1-on-1 Deloitte mentors. Paid; co-author thought-leadership with Deloitte Future-of-Canada Centre.",
            requirements: ["Self-identified First Nations, Inuit, Métis undergrads/grads"],
            benefits: ["Paid", "Co-author thought-leadership", "1-on-1 Deloitte mentors"],
            deadline: dateFormatter.date(from: "January 31, 2025"),
            startDate: nil,
            endDate: nil,
            location: "Canada (remote/various)",
            isRemote: true,
            website: "https://indigenousyouthroots.ca",
            tags: ["internship", "policy", "indigenous", "government", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Interactive Ontario Work-Placement Program (Video-game/XR)",
            type: .internship,
            category: .technology,
            organization: "Interactive Ontario",
            description: "Get hands-on inside Ontario game/XR studios; receive 3 personalised coaching sessions. Paid studio placement + career-readiness coaching.",
            requirements: ["Black youth & emerging pros 19–35, Ontario residents"],
            benefits: ["Paid studio placement", "Career-readiness coaching", "3 personalised coaching sessions"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Ontario",
            isRemote: false,
            website: "https://interactiveontario.com",
            tags: ["internship", "video game", "xr", "technology", "ontario"]
        ))
        opportunities.append(Opportunity(
            title: "Synergy Biomedical Engineering Research Program – UBC SBME",
            type: .internship,
            category: .stem,
            organization: "UBC School of Biomedical Engineering (SBME)",
            description: "Six-week wet-lab or device-design project, weekly PD & final research-day showcase. ~$15–18/hr + pro-dev events.",
            requirements: ["Undergrads (any STEM); priority 2nd–3rd yr"],
            benefits: ["~$15–18/hr", "Pro-dev events", "Weekly PD", "Final research-day showcase"],
            deadline: nil,
            startDate: dateFormatter.date(from: "May 2, 2025"),
            endDate: dateFormatter.date(from: "August 22, 2025"),
            location: "Vancouver, BC",
            isRemote: false,
            stipend: 16.5,
            website: "https://bme.ubc.ca",
            tags: ["internship", "biomedical", "engineering", "ubc", "stem", "canada"]
        ))
        
        // --- Added: BC, Federal, and International Youth Internships ---
        opportunities.append(Opportunity(
            title: "Workforce Development – Work Experience Opportunities Grant (BC)",
            type: .internship,
            category: .business,
            organization: "United Way BC + BC Ministry of Social Development",
            description: "Non-profits host placements that build in-demand skills in customer service, admin, and community engagement, improving youth employability.",
            requirements: ["Youth aged 15–30 on income or disability assistance"],
            benefits: ["Paid work experience", "$7.7M allocated over two years", "Skill-building in customer service, admin, community engagement"],
            deadline: dateFormatter.date(from: "July 15, 2025"),
            startDate: nil,
            endDate: nil,
            location: "British Columbia",
            isRemote: false,
            website: "https://www2.gov.bc.ca",
            tags: ["internship", "workforce", "youth", "bc", "business", "community"]
        ))
        opportunities.append(Opportunity(
            title: "B.C. Indigenous Youth Internship Program (IYIP)",
            type: .internship,
            category: .socialJustice,
            organization: "BC Public Service Agency",
            description: "Spend 9 months in a BC ministry, followed by 3 months in an Indigenous organization, leading projects in policy, community relations, or admin.",
            requirements: ["First Nations, Métis, or Inuit youth aged 19–29 residing in BC"],
            benefits: ["$59,015.56 annual salary", "Full benefits", "Cohort-based support"],
            deadline: dateFormatter.date(from: "April 30, 2025"),
            startDate: dateFormatter.date(from: "September 8, 2025"),
            endDate: dateFormatter.date(from: "August 31, 2026"),
            location: "British Columbia",
            isRemote: false,
            website: "https://www2.gov.bc.ca",
            tags: ["internship", "indigenous", "youth", "bc", "policy", "social justice"]
        ))
        opportunities.append(Opportunity(
            title: "B.C. Work‑Able Graduate Internships",
            type: .internship,
            category: .business,
            organization: "BC Public Service",
            description: "Meaningful work across government ministries, with mentorship, orientation, and professional development for recent grads with disabilities.",
            requirements: ["Recent post-secondary grads with disabilities (within 3 years), residents of BC"],
            benefits: ["Paid full-time for 12 months", "Learning allowance", "Accommodations", "Mentorship"],
            deadline: nil,
            startDate: dateFormatter.date(from: "September 1, 2026"),
            endDate: dateFormatter.date(from: "August 31, 2027"),
            location: "British Columbia",
            isRemote: false,
            website: "https://www2.gov.bc.ca",
            tags: ["internship", "disability", "bc", "government", "business"]
        ))
        opportunities.append(Opportunity(
            title: "B.C. Equity Internship Program",
            type: .internship,
            category: .socialJustice,
            organization: "BC Ministry of Social Development & Poverty Reduction",
            description: "Lead equity-focused projects, collaborate across teams, and drive bias reduction initiatives within government.",
            requirements: ["BIPOC or 2SLGBTQ+ identifying individuals with leadership or project experience (high school grads or equivalent)"],
            benefits: ["Paid, full-time", "Peer support", "Leadership coaching"],
            deadline: dateFormatter.date(from: "April 30, 2025"),
            startDate: dateFormatter.date(from: "September 1, 2025"),
            endDate: dateFormatter.date(from: "August 31, 2026"),
            location: "British Columbia",
            isRemote: false,
            website: "https://www2.gov.bc.ca",
            tags: ["internship", "equity", "bipoc", "2slgbtq", "bc", "social justice"]
        ))
        opportunities.append(Opportunity(
            title: "International Youth Internship Program – YMCA Greater Toronto",
            type: .internship,
            category: .socialJustice,
            organization: "YMCA GTA + Global Affairs Canada",
            description: "Work abroad (4–6 months) supporting Sustainable Development goals in communities across Africa or Latin America; includes pre- and re-entry training.",
            requirements: ["Canadian citizens/PR, aged 18–30, with lived experience as Indigenous, racialized, 2SLGBTQIA+, or with a disability"],
            benefits: ["Flights", "Daily stipend", "Visa", "Insurance", "Housing", "Language training"],
            deadline: dateFormatter.date(from: "May 30, 2025"),
            startDate: dateFormatter.date(from: "June 28, 2025"),
            endDate: dateFormatter.date(from: "December 16, 2025"),
            location: "Africa or Latin America",
            isRemote: false,
            website: "https://ymcagta.org",
            tags: ["internship", "international", "ymca", "youth", "social justice"]
        ))
        opportunities.append(Opportunity(
            title: "Science Horizons Youth Internship Program",
            type: .internship,
            category: .environment,
            organization: "Environment & Climate Change Canada",
            description: "Paid internships in climate, forestry, mining, clean tech, and engineering roles with employer and government oversight.",
            requirements: ["Recent college/university/polytechnic grads (STEM & environmental majors)"],
            benefits: ["Up to $25,000 wage subsidy", "Up to $5,000 for training/support"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada (various)",
            isRemote: false,
            website: "https://natural-resources.canada.ca",
            tags: ["internship", "science horizons", "environment", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Computers for Schools Intern Program (CFSI)",
            type: .internship,
            category: .technology,
            organization: "Innovation, Science & Economic Development Canada",
            description: "Technical and outreach roles—repair, software deployment, community training, network setups.",
            requirements: ["Canadian youth aged 15–30 (citizen, PR, or refugee), legal to work"],
            benefits: ["Paid", "Refurbish and upgrade computers", "Community training"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada (various)",
            isRemote: false,
            website: "https://ised-isde.canada.ca",
            tags: ["internship", "computers", "technology", "schools", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Natural Resources Canada – STIP Green Jobs",
            type: .internship,
            category: .environment,
            organization: "Natural Resources Canada",
            description: "Interns work in forestry, mining, clean energy, earth sciences, and Indigenous economies with practical training.",
            requirements: ["Youth aged 15–30 (citizen, PR, refugee), available ≥30 h/week"],
            benefits: ["Subsidized by employers", "Wage varies based on host", "Practical training"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada (various)",
            isRemote: false,
            website: "https://natural-resources.canada.ca",
            tags: ["internship", "stip", "green jobs", "environment", "canada"]
        ))
        
        // --- Added: Perimeter, Museum, Ocean, Journalism, and Editorial Internships ---
        opportunities.append(Opportunity(
            title: "PSI Start Research Internship – Perimeter Institute (Waterloo, ON)",
            type: .internship,
            category: .research,
            organization: "Perimeter Institute",
            description: "Pair with a Perimeter researcher on frontier theory (quantum gravity, cosmology, Q information). Present at end-of-summer symposium.",
            requirements: ["Undergrad Physics/Math/CS students (Canadian & intl)", "min 12 weeks"],
            benefits: ["Paid research award", "Economy travel", "Weekday meal credits at PI's Bistro"],
            deadline: dateFormatter.date(from: "January 31, 2025"),
            startDate: dateFormatter.date(from: "May 5, 2025"),
            endDate: dateFormatter.date(from: "August 15, 2025"),
            location: "Waterloo, ON",
            isRemote: false,
            website: "https://perimeterinstitute.ca",
            tags: ["internship", "perimeter", "research", "physics", "math", "cs", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Indigenous Internship Program – Canadian Museum of History (Gatineau, QC)",
            type: .internship,
            category: .humanities,
            organization: "Canadian Museum of History",
            description: "Work with curators on repatriation, exhibit design, collections management; includes museum-studies training & TRC-aligned practice.",
            requirements: ["First Nations, Inuit, Métis college/university students or community members"],
            benefits: ["Competitive salary", "Travel & housing assistance (for in-person track)", "Museum-studies training"],
            deadline: dateFormatter.date(from: "May 16, 2025"),
            startDate: nil,
            endDate: nil,
            location: "Gatineau, QC",
            isRemote: false,
            website: "https://historymuseum.ca",
            tags: ["internship", "indigenous", "museum", "history", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Ocean Bridge Classic / Direct Action – Ocean Wise",
            type: .internship,
            category: .environment,
            organization: "Ocean Wise",
            description: "Serve as an Ocean Ambassador: two wilderness 'learning journeys,' 120h marine-service project, $ subs for internet/child-care, and national youth network.",
            requirements: ["Canadians 18–30 (any background) passionate about oceans"],
            benefits: ["All travel, gear, food and project costs covered", "$500 service-project micro-grant"],
            deadline: dateFormatter.date(from: "March 11, 2025"),
            startDate: dateFormatter.date(from: "April 1, 2025"),
            endDate: dateFormatter.date(from: "September 30, 2025"),
            location: "Canada (various)",
            isRemote: false,
            website: "https://ocean.org",
            tags: ["internship", "ocean", "marine", "ambassador", "environment", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Indigenous Editorial Fellowship – The Narwhal",
            type: .internship,
            category: .arts,
            organization: "The Narwhal",
            description: "Learn fact-checking & editing for award-winning environmental newsroom; focus on Indigenous-led conservation stories.",
            requirements: ["First Nations, Métis, Inuit (or Native American in Canada) emerging journalists"],
            benefits: ["$30.77/hr (30 h/wk)", "Work laptop", "Fully remote"],
            deadline: dateFormatter.date(from: "April 25, 2025"),
            startDate: dateFormatter.date(from: "June 2, 2025"),
            endDate: dateFormatter.date(from: "August 22, 2025"),
            location: nil,
            isRemote: true,
            website: "https://thenarwhal.ca",
            tags: ["internship", "editorial", "indigenous", "journalism", "arts", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "CJF-CP News Creator Fellowship – Canadian Journalism Foundation × The Canadian Press",
            type: .internship,
            category: .arts,
            organization: "Canadian Journalism Foundation × The Canadian Press",
            description: "Produce local-news video packages with CP editors; receive YouTube News storytelling certification.",
            requirements: ["Spring 2025 j-school grads or journalists (1–3 yrs)"],
            benefits: ["$5,500 stipend", "CP & YouTube Canada video-training boot-camp"],
            deadline: dateFormatter.date(from: "January 31, 2025"),
            startDate: dateFormatter.date(from: "May 1, 2025"),
            endDate: dateFormatter.date(from: "June 15, 2025"),
            location: nil,
            isRemote: true,
            website: "https://cjf-fjc.ca",
            tags: ["internship", "journalism", "news", "arts", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Ocean Bridge Expression-of-Interest Pool (Future Cohorts)",
            type: .internship,
            category: .environment,
            organization: "Ocean Wise",
            description: "Join 140 peers nationwide, design and deliver community ocean-health projects, receive extensive barrier-removal supports.",
            requirements: ["Canadians 19–30 ready to give ~5 h/wk to waterway action"],
            benefits: ["All program travel", "iPad/internet/gear subsidies", "$500 project grant", "Well-being supports"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada (various)",
            isRemote: false,
            website: "https://ocean.org",
            tags: ["internship", "ocean", "community", "environment", "canada"]
        ))
        
        // --- Added: Major Canadian and International Fellowships ---
        opportunities.append(Opportunity(
            title: "SHAD Canada – STEAM + Entrepreneurship Fellowship",
            type: .fellowship,
            category: .entrepreneurship,
            organization: "SHAD Canada",
            description: "27-day residential program on 30 campuses; design sprint on a national 'real-world challenge,' daily labs & speaker series.",
            requirements: ["Grade 10–11 students in any province/territory"],
            benefits: ["Fee $6,335; $5M in need-based bursaries (many pay $0)", "Residential program", "Labs & speaker series"],
            deadline: dateFormatter.date(from: "December 1, 2024"),
            startDate: dateFormatter.date(from: "June 29, 2025"),
            endDate: dateFormatter.date(from: "July 25, 2025"),
            location: "30 campuses across Canada",
            isRemote: false,
            website: "https://shad.ca",
            tags: ["fellowship", "shad", "steam", "entrepreneurship", "canada", "high school"]
        ))
        opportunities.append(Opportunity(
            title: "McCall MacBain International Fellowship",
            type: .fellowship,
            category: .general,
            organization: "McCall MacBain Foundation",
            description: "Learn a new language, study at a host uni, then complete a paid placement—fully funded global gap year.",
            requirements: ["Canadian citizens/PR, age 19–24, at McGill, McMaster, Dal, U Manitoba"],
            benefits: ["Up to $30,000 for language term + study term + paid work term"],
            deadline: dateFormatter.date(from: "January 13, 2025"),
            startDate: dateFormatter.date(from: "August 1, 2025"),
            endDate: dateFormatter.date(from: "August 31, 2026"),
            location: "Global",
            isRemote: false,
            website: "https://mccallmacbain.org",
            tags: ["fellowship", "international", "gap year", "canada", "study abroad"]
        ))
        opportunities.append(Opportunity(
            title: "Mitacs Globalink Research Award (GRA)",
            type: .fellowship,
            category: .research,
            organization: "Mitacs",
            description: "12- to 24-week research project abroad with a host supervisor; Mitacs handles funds & insurance.",
            requirements: ["Senior undergrads, grad students & PDFs, any discipline"],
            benefits: ["$6,000 travel & research grant"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Global",
            isRemote: false,
            website: "https://mitacs.ca",
            tags: ["fellowship", "mitacs", "research", "global", "award"]
        ))
        opportunities.append(Opportunity(
            title: "Action Canada Public-Policy Fellowship",
            type: .fellowship,
            category: .socialJustice,
            organization: "Action Canada",
            description: "Four week-long study tours (e.g., Yukon, Québec), 10 virtual sessions, group policy project, national network.",
            requirements: ["Emerging leaders (≈ age 25–35) from any sector"],
            benefits: ["All study-tour travel, meals & lodging covered"],
            deadline: nil,
            startDate: dateFormatter.date(from: "May 1, 2026"),
            endDate: dateFormatter.date(from: "March 31, 2027"),
            location: "Canada (various)",
            isRemote: false,
            website: "https://actioncanada.ca",
            tags: ["fellowship", "public policy", "leadership", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "POLAR Knowledge Canada Fellowship",
            type: .fellowship,
            category: .research,
            organization: "POLAR Knowledge Canada",
            description: "One-year Arctic research fellowship aligned with POLAR S&T goals; supports community & Indigenous collaboration.",
            requirements: ["Post-docs or visiting researchers hosted by a Northern institute"],
            benefits: ["$50,000 lump-sum award"],
            deadline: dateFormatter.date(from: "February 24, 2025"),
            startDate: nil,
            endDate: nil,
            location: "Northern Canada",
            isRemote: false,
            website: "https://canada.ca",
            tags: ["fellowship", "arctic", "research", "polar", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Parliamentary Internship Programme (PIP)",
            type: .fellowship,
            category: .business,
            organization: "Parliament of Canada",
            description: "Ten months on Parliament Hill—half with a gov't MP, half with opposition; study tours to Brussels & Nunavut.",
            requirements: ["Recent grads (any major) across Canada"],
            benefits: ["$35,000 scholarship + grad cert (U Ottawa)"],
            deadline: dateFormatter.date(from: "January 31, 2026"),
            startDate: dateFormatter.date(from: "September 1, 2026"),
            endDate: dateFormatter.date(from: "June 30, 2027"),
            location: "Ottawa, ON",
            isRemote: false,
            website: "https://pip-psp.org",
            tags: ["fellowship", "parliament", "internship", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Ontario Legislative Internship Programme (OLIP)",
            type: .fellowship,
            category: .business,
            organization: "Ontario Legislature",
            description: "10-month placement at Queen's Park with two MPPs; non-partisan, includes North America & European study trips.",
            requirements: ["Univ. grads ≤ 2 yrs out, any major"],
            benefits: ["≈$2,700/mo + $1,000 paper bonus"],
            deadline: dateFormatter.date(from: "January 31, 2026"),
            startDate: dateFormatter.date(from: "September 1, 2026"),
            endDate: dateFormatter.date(from: "June 30, 2027"),
            location: "Toronto, ON",
            isRemote: false,
            website: "https://olipinterns.ca",
            tags: ["fellowship", "legislative", "internship", "ontario"]
        ))
        opportunities.append(Opportunity(
            title: "Pathy Foundation Fellowship",
            type: .fellowship,
            category: .socialJustice,
            organization: "Pathy Foundation",
            description: "Launch your own community-change initiative anywhere in the world with year-long coaching & funding.",
            requirements: ["Final-year undergrads at 12 partner universities"],
            benefits: ["$50,000 living + project budget + Coady Institute training"],
            deadline: dateFormatter.date(from: "December 15, 2024"),
            startDate: dateFormatter.date(from: "May 1, 2025"),
            endDate: dateFormatter.date(from: "May 31, 2026"),
            location: "Global",
            isRemote: false,
            website: "https://pathyfellowship.com",
            tags: ["fellowship", "pathy", "community", "social justice", "global"]
        ))
        opportunities.append(Opportunity(
            title: "Early-Career Banff Artist-in-Residence (BAiR) – Banff Centre",
            type: .fellowship,
            category: .arts,
            organization: "Banff Centre",
            description: "One-month intensive residency in the Rockies, 24/7 studio, faculty critiques, open-studio showcase.",
            requirements: ["Emerging visual artists/curators (18+)", "Program Jul 21 – Aug 22, 2025"],
            benefits: ["Subsidised studio", "Housing & mentored workshops", "Tuition bursaries available"],
            deadline: dateFormatter.date(from: "November 30, 2025"),
            startDate: dateFormatter.date(from: "July 21, 2025"),
            endDate: dateFormatter.date(from: "August 22, 2025"),
            location: "Banff, AB",
            isRemote: false,
            website: "https://banffcentre.ca",
            tags: ["fellowship", "banff", "arts", "residency", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Digital Policy Hub Fellowship – CIGI × Mitacs",
            type: .fellowship,
            category: .technology,
            organization: "CIGI × Mitacs",
            description: "Join an eight-month cohort tackling AI/tech-policy projects; hybrid, travel to Waterloo for conferences.",
            requirements: ["Master's, PhD, post-docs (all disciplines) based at Canadian institutions"],
            benefits: ["Mitacs Accelerate stipend ($15,000–$20,000)", "CIGI workspace & seminars"],
            deadline: dateFormatter.date(from: "March 3, 2025"),
            startDate: dateFormatter.date(from: "September 1, 2025"),
            endDate: dateFormatter.date(from: "April 30, 2026"),
            location: "Waterloo, ON",
            isRemote: false,
            website: "https://cigionline.org",
            tags: ["fellowship", "digital policy", "mitacs", "technology", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "IBET Momentum Fellowship (18 STEM Faculties)",
            type: .fellowship,
            category: .stem,
            organization: "IBET Momentum",
            description: "Full-ride PhD funding, mentoring by faculty + industry; annual IBET networking conference.",
            requirements: ["Incoming Indigenous & Black Engineering PhD students"],
            benefits: ["$30,000 per yr × 4 yrs + Mitacs internship option"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada (18 STEM Faculties)",
            isRemote: false,
            website: "https://en.wikipedia.org/wiki/Indigenous_and_Black_Engineering_and_Technology_PhD_Project",
            tags: ["fellowship", "ibet", "stem", "phd", "indigenous", "black", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Perimeter PSI-Start Research Fellowship",
            type: .fellowship,
            category: .research,
            organization: "Perimeter Institute",
            description: "12-week theory project with Perimeter scientists; end-of-summer symposium in Waterloo.",
            requirements: ["Undergrad Physics/Math/CS worldwide (Canadians priority)"],
            benefits: ["Paid research award", "Travel", "On-site meals"],
            deadline: dateFormatter.date(from: "January 31, 2025"),
            startDate: dateFormatter.date(from: "May 5, 2025"),
            endDate: dateFormatter.date(from: "August 15, 2025"),
            location: "Waterloo, ON",
            isRemote: false,
            website: "https://cigionline.org",
            tags: ["fellowship", "perimeter", "research", "physics", "math", "cs", "canada"]
        ))
        
        // --- Added: More Canadian and International Fellowships ---
        opportunities.append(Opportunity(
            title: "Youth Ambassador Fellowship Canada 2026",
            type: .fellowship,
            category: .socialJustice,
            organization: "Youth Ambassador Fellowship Canada",
            description: "Engage in workshops, keynote speeches, and cultural exchanges focused on human rights, social justice, peacebuilding, and experiential learning.",
            requirements: ["Individuals aged 16–45 with a strong background in leadership, advocacy, research, or community engagement."],
            benefits: ["Self-funded; optional paid add-ons for accommodation and travel"],
            deadline: nil,
            startDate: dateFormatter.date(from: "March 27, 2026"),
            endDate: dateFormatter.date(from: "March 30, 2026"),
            location: "Montreal, QC",
            isRemote: false,
            website: "https://youthambassadorfellowship.org",
            tags: ["fellowship", "youth", "ambassador", "social justice", "canada", "leadership"]
        ))
        opportunities.append(Opportunity(
            title: "Aga Khan Foundation Canada – International Youth Fellowship",
            type: .fellowship,
            category: .socialJustice,
            organization: "Aga Khan Foundation Canada",
            description: "Eight-month placements in Africa or Asia focusing on international development, microfinance, or media. Fully funded, including travel, accommodation, vaccinations, health insurance, and a modest living stipend.",
            requirements: ["Canadian citizens or permanent residents aged 30 or under with a completed undergraduate degree."],
            benefits: ["Fully funded", "Travel, accommodation, vaccinations, health insurance, living stipend"],
            deadline: nil,
            startDate: dateFormatter.date(from: "May 28, 2025"),
            endDate: dateFormatter.date(from: "February 28, 2026"),
            location: "Africa or Asia (with pre-departure in Ottawa)",
            isRemote: false,
            website: "https://akfc.ca",
            tags: ["fellowship", "aga khan", "international", "youth", "development", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Diversity Youth Fellowship",
            type: .fellowship,
            category: .socialJustice,
            organization: "Diversity Youth Fellowship",
            description: "Hands-on political and community service experience, including case projects, leadership development, mentorship, and networking opportunities.",
            requirements: ["University students or recent graduates with demonstrated civic engagement and an understanding of community issues."],
            benefits: ["Leadership development", "Mentorship", "Networking", "Community service experience"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada (various)",
            isRemote: false,
            website: "https://youthfellowship.ca",
            tags: ["fellowship", "diversity", "youth", "leadership", "community", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Writers' Trust Fellowship",
            type: .fellowship,
            category: .arts,
            organization: "Writers' Trust of Canada",
            description: "Provides creative freedom to work on the next book, including a two-week, self-directed residency at The Banff Centre.",
            requirements: ["Established Canadian writers with a strong publishing track record in fiction, literary nonfiction, poetry, or literature for young people."],
            benefits: ["$50,000 fellowship", "Two-week residency at The Banff Centre"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Banff, AB",
            isRemote: false,
            website: "https://en.wikipedia.org/wiki/Writers%27_Trust_of_Canada",
            tags: ["fellowship", "writers", "arts", "banff", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Richard J. Schmeelk Canada Fellowship",
            type: .fellowship,
            category: .general,
            organization: "Richard J. Schmeelk Canada Fellowship",
            description: "Supports postgraduate studies at eligible universities, promoting bilingualism and cultural exchange within Canada.",
            requirements: ["Canadian citizens pursuing master's or doctoral studies in Canada's other official language."],
            benefits: ["$10,000 per semester for up to four semesters"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada (various)",
            isRemote: false,
            website: "https://en.wikipedia.org/wiki/Richard_J._Schmeelk_Canada_Fellowship",
            tags: ["fellowship", "schmeelk", "bilingualism", "graduate", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "Frank Knox Memorial Fellowship",
            type: .fellowship,
            category: .general,
            organization: "Frank Knox Memorial Fellowship",
            description: "Provides an opportunity to undertake graduate study at Harvard University, fostering international collaboration and academic excellence.",
            requirements: ["Canadian citizens accepted into a graduate program at Harvard University."],
            benefits: ["Full tuition and living expenses for the duration of the graduate program"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Harvard University, USA",
            isRemote: false,
            website: "https://www.frankknox.harvard.edu/",
            tags: ["fellowship", "frank knox", "harvard", "graduate", "canada"]
        ))
        
        // --- Added: More 2025–2026 Fellowships ---
        opportunities.append(Opportunity(
            title: "Toronto Metropolitan University Catalyst Fellowship Program 2025",
            type: .fellowship,
            category: .technology,
            organization: "Toronto Metropolitan University",
            description: "Engage in cutting-edge cybersecurity research and industry engagement projects. Fully funded, including a stipend and access to research resources.",
            requirements: ["Students and recent graduates interested in cybersecurity and digital innovation."],
            benefits: ["Fully funded", "Stipend", "Access to research resources"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Toronto, ON",
            isRemote: false,
            website: "https://en.wikipedia.org/wiki/Toronto_Metropolitan_University",
            tags: ["fellowship", "catalyst", "cybersecurity", "technology", "toronto"]
        ))
        opportunities.append(Opportunity(
            title: "Young Leaders of the Americas (YLAI) Fellowship Program 2026",
            type: .fellowship,
            category: .entrepreneurship,
            organization: "YLAI / U.S. Department of State",
            description: "Participate in a professional development program in the United States, including a fellowship with a U.S. host organization. Fully funded, covering travel, accommodation, and a living stipend.",
            requirements: ["Emerging entrepreneurs and civil society leaders aged 25–35 from the Americas."],
            benefits: ["Fully funded", "Travel", "Accommodation", "Living stipend"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "United States",
            isRemote: false,
            website: "https://ylai.state.gov/",
            tags: ["fellowship", "ylai", "americas", "entrepreneurship", "leadership"]
        ))
        opportunities.append(Opportunity(
            title: "IRPP Postdoctoral Research Fellowship 2025",
            type: .fellowship,
            category: .research,
            organization: "Institute for Research on Public Policy (IRPP)",
            description: "Conduct policy-relevant research at the Institute for Research on Public Policy. $70,000 stipend for one year.",
            requirements: ["Postdoctoral scholars from Indigenous, Black, and other racialized communities."],
            benefits: ["$70,000 stipend for one year"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada (remote/various)",
            isRemote: true,
            website: "https://irpp.org/",
            tags: ["fellowship", "irpp", "postdoc", "research", "policy", "canada"]
        ))
        opportunities.append(Opportunity(
            title: "FutureBUILDS NEXT Fellowship Program 2025",
            type: .fellowship,
            category: .socialJustice,
            organization: "FutureBUILDS / Toronto Community Housing",
            description: "Develop leadership skills and gain experience in the nonprofit housing sector. Fully funded, including a stipend and training resources.",
            requirements: ["Emerging Black leaders in nonprofit housing in Toronto."],
            benefits: ["Fully funded", "Stipend", "Training resources"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Toronto, ON",
            isRemote: false,
            website: "https://www.torontohousing.ca/",
            tags: ["fellowship", "futurebuilds", "housing", "leadership", "social justice", "toronto"]
        ))
        opportunities.append(Opportunity(
            title: "Huntington Society of Canada Undergraduate Student Summer Fellowship 2025",
            type: .fellowship,
            category: .healthcare,
            organization: "Huntington Society of Canada",
            description: "Conduct research under the supervision of a faculty member in Canada. $5,000 stipend.",
            requirements: ["Undergraduate students interested in neuroscience and Huntington disease research."],
            benefits: ["$5,000 stipend"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada (various)",
            isRemote: false,
            website: "https://www.huntingtonsociety.ca/",
            tags: ["fellowship", "huntington", "neuroscience", "healthcare", "canada"]
        ))
        
        // --- 2025 Canadian Conferences & Hackathons ---
        opportunities.append(Opportunity(
            title: "Hack the North 2025",
            type: .conference,
            category: .technology,
            organization: "Hack the North",
            description: "Canada's largest hackathon with 1,000+ students collaborating over 36 hours to build creative projects. Workshops, mentorship from industry leaders, and prize pools over $100,000 CAD. Focus areas include AI, sustainability, healthcare, fintech, and more. Includes travel bursaries for Canadian participants.",
            requirements: ["Open to all university and college students worldwide, including Canadian students"],
            benefits: ["Workshops", "Mentorship from industry leaders", "Prize pools over $100,000 CAD", "Travel bursaries for Canadians"],
            deadline: nil,
            startDate: dateFormatter.date(from: "September 20, 2025"),
            endDate: dateFormatter.date(from: "September 22, 2025"),
            location: "University of Waterloo, Waterloo, ON (In-person & Virtual)",
            isRemote: true,
            applicationUrl: "https://hackthenorth.com",
            tags: ["hackathon", "technology", "AI", "sustainability", "healthcare", "fintech", "canada", "waterloo"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "CIVIC Tech Toronto Hackathon 2025",
            type: .conference,
            category: .socialJustice,
            organization: "CIVIC Tech Toronto",
            description: "Focus on civic engagement and social impact projects using technology. Participants work on solutions for public policy, open data, and community improvement. Mentors include city officials and tech experts. Opportunity to pitch projects to city councils.",
            requirements: ["Canadian students", "Civic tech enthusiasts", "Community organizers"],
            benefits: ["Mentorship from city officials and tech experts", "Pitch projects to city councils"],
            deadline: nil,
            startDate: dateFormatter.date(from: "August 15, 2025"),
            endDate: dateFormatter.date(from: "August 17, 2025"),
            location: "Toronto Public Library, Toronto, ON",
            isRemote: false,
            applicationUrl: "https://civictech.ca",
            tags: ["hackathon", "civic tech", "social impact", "public policy", "open data", "community", "toronto"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "HackCamp 2025",
            type: .conference,
            category: .technology,
            organization: "HackCamp",
            description: "A summer camp-style hackathon focused on introducing students to programming, app development, and design thinking. Includes daily workshops, guest speakers from Canadian tech startups, and team hack projects.",
            requirements: ["Canadian high school and university students interested in tech and entrepreneurship"],
            benefits: ["Daily workshops", "Guest speakers from Canadian tech startups", "Team hack projects"],
            deadline: nil,
            startDate: dateFormatter.date(from: "July 10, 2025"),
            endDate: dateFormatter.date(from: "July 13, 2025"),
            location: "Virtual",
            isRemote: true,
            applicationUrl: "https://hackcamp.ca",
            tags: ["hackathon", "technology", "entrepreneurship", "workshops", "virtual", "canada"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Canadian Undergraduate Physics Conference (CUPC) 2025",
            type: .conference,
            category: .stem,
            organization: "CUPC",
            description: "Annual conference where students present research posters and talks. Includes keynote lectures by leading physicists, networking sessions, and workshops on research skills.",
            requirements: ["Undergraduate physics students from Canadian universities"],
            benefits: ["Keynote lectures", "Networking sessions", "Workshops on research skills"],
            deadline: nil,
            startDate: dateFormatter.date(from: "May 23, 2025"),
            endDate: dateFormatter.date(from: "May 25, 2025"),
            location: "McGill University, Montréal, QC",
            isRemote: false,
            applicationUrl: "https://cupc.ca",
            tags: ["conference", "physics", "research", "networking", "canada", "mcgill"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Women in Tech Summit Toronto 2025",
            type: .conference,
            category: .technology,
            organization: "Women in Tech Summit",
            description: "Conference featuring keynote speakers from top Canadian tech companies, panel discussions on diversity and inclusion, hands-on workshops, and networking sessions. Scholarships available for student attendees.",
            requirements: ["Female and non-binary students and professionals interested in technology careers"],
            benefits: ["Keynote speakers", "Panel discussions", "Workshops", "Networking", "Scholarships for students"],
            deadline: nil,
            startDate: dateFormatter.date(from: "October 8, 2025"),
            endDate: dateFormatter.date(from: "October 8, 2025"),
            location: "Metro Toronto Convention Centre, Toronto, ON",
            isRemote: false,
            applicationUrl: "https://wit.ca",
            tags: ["conference", "women in tech", "diversity", "inclusion", "workshops", "toronto", "canada"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Canadian Game Jam 2025",
            type: .conference,
            category: .technology,
            organization: "Canadian Game Jam",
            description: "48-hour game development competition encouraging creativity and teamwork. Participants design and build games from scratch. Prizes for best design, innovation, and storytelling. Includes workshops on game design and marketing.",
            requirements: ["Canadian game developers, students, and hobbyists"],
            benefits: ["Prizes for best design, innovation, and storytelling", "Workshops on game design and marketing"],
            deadline: nil,
            startDate: dateFormatter.date(from: "April 18, 2025"),
            endDate: dateFormatter.date(from: "April 20, 2025"),
            location: "Online and select campuses across Canada",
            isRemote: true,
            applicationUrl: "https://canadiangamejam.com",
            tags: ["game jam", "competition", "game development", "workshops", "canada", "online"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "IEEE Canada Student Congress 2025",
            type: .conference,
            category: .stem,
            organization: "IEEE Canada",
            description: "Student-led conference with technical paper presentations, workshops, and competitions. Opportunities to connect with IEEE professionals, attend career talks, and participate in design contests.",
            requirements: ["Engineering and tech students across Canada"],
            benefits: ["Technical paper presentations", "Workshops", "Competitions", "Career talks", "Design contests"],
            deadline: nil,
            startDate: dateFormatter.date(from: "June 12, 2025"),
            endDate: dateFormatter.date(from: "June 14, 2025"),
            location: "University of British Columbia, Vancouver, BC",
            isRemote: false,
            applicationUrl: "https://ieee.ca",
            tags: ["conference", "ieee", "engineering", "technology", "workshops", "canada", "ubc"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        
        // --- 2025 Canadian Hackathons & Conferences (Batch 2) ---
        opportunities.append(Opportunity(
            title: "Hack the 6ix 2025",
            type: .conference,
            category: .technology,
            organization: "Hack the 6ix",
            description: "Canada's largest summer student-run hackathon, hosting over 1,000 participants. Offers $15,000 in prizes, mentorship from industry leaders, and workshops across various tech domains.",
            requirements: ["Open to all students worldwide"],
            benefits: ["$15,000 in prizes", "Mentorship from industry leaders", "Workshops across tech domains"],
            deadline: nil,
            startDate: dateFormatter.date(from: "July 18, 2025"),
            endDate: dateFormatter.date(from: "July 20, 2025"),
            location: "York University, Toronto, ON",
            isRemote: false,
            applicationUrl: "https://hackthe6ix.com",
            tags: ["hackathon", "technology", "prizes", "mentorship", "workshops", "toronto", "canada"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Startup Hackathon 2025",
            type: .conference,
            category: .technology,
            organization: "Startup Hackathon",
            description: "A 24-hour event focused on building real solutions in a collaborative space. Participants will have the opportunity to network, enhance their skills, and compete for prizes.",
            requirements: ["Students", "Developers", "Designers", "Creators"],
            benefits: ["Networking", "Skill enhancement", "Prizes"],
            deadline: nil,
            startDate: dateFormatter.date(from: "May 30, 2025"),
            endDate: dateFormatter.date(from: "May 31, 2025"),
            location: "University of the Fraser Valley, Chilliwack, BC",
            isRemote: false,
            applicationUrl: "https://csa.ufv.ca",
            tags: ["hackathon", "startup", "technology", "networking", "prizes", "bc", "canada"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "TechNova 2025",
            type: .conference,
            category: .technology,
            organization: "TechNova",
            description: "An inclusive hackathon aiming to empower women and non-binary individuals in the tech industry. Participants will engage in workshops, mentorship sessions, and collaborative projects.",
            requirements: ["Women and non-binary individuals in tech"],
            benefits: ["Workshops", "Mentorship sessions", "Collaborative projects"],
            deadline: nil,
            startDate: dateFormatter.date(from: "September 26, 2025"),
            endDate: dateFormatter.date(from: "September 28, 2025"),
            location: "University of Waterloo, Waterloo, ON",
            isRemote: false,
            applicationUrl: "https://itstechnova.org",
            tags: ["hackathon", "technology", "women", "non-binary", "mentorship", "workshops", "waterloo", "canada"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Sask Polytech Hack 2025",
            type: .conference,
            category: .technology,
            organization: "Saskatchewan Polytechnic",
            description: "A hackathon focused on improving public safety through technology. Participants will work on prototypes addressing challenges faced by marginalized communities. Mentorship from industry experts will be provided.",
            requirements: ["Students interested in public safety and technology"],
            benefits: ["Mentorship from industry experts", "Prototyping for public safety"],
            deadline: nil,
            startDate: dateFormatter.date(from: "March 6, 2025"),
            endDate: dateFormatter.date(from: "March 7, 2025"),
            location: "Saskatchewan Polytechnic, Regina and Saskatoon, SK",
            isRemote: false,
            applicationUrl: "https://saskpolytech.ca",
            tags: ["hackathon", "public safety", "technology", "mentorship", "saskatchewan", "canada"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Digital Innovation in Education Conference 2025",
            type: .conference,
            category: .technology,
            organization: "Ontario Tech University",
            description: "A conference exploring the integration of AI tools in education, focusing on accessibility and inclusivity. Sessions will include live demonstrations and interactive discussions.",
            requirements: ["Educators and researchers in digital innovation"],
            benefits: ["Live demonstrations", "Interactive discussions", "Focus on accessibility and inclusivity"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Ontario Tech University, Oshawa, ON",
            isRemote: false,
            applicationUrl: "https://education.ontariotechu.ca",
            tags: ["conference", "education", "AI", "accessibility", "inclusivity", "digital innovation", "ontario", "canada"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        
        // --- 2025 Canadian Science, Math, and STEM Competitions ---
        opportunities.append(Opportunity(
            title: "Canada-Wide Science Fair (CWSF) 2025",
            type: .competition,
            category: .stem,
            organization: "Youth Science Canada",
            description: "Canada's largest youth STEM event, featuring 339 innovative projects from young scientists. Public viewing on June 1, 5, and 6. Top students from regional science fairs across Canada compete.",
            requirements: ["Top students from regional science fairs across Canada"],
            benefits: ["National recognition", "STEM networking", "Project showcase"],
            deadline: nil,
            startDate: dateFormatter.date(from: "May 31, 2025"),
            endDate: dateFormatter.date(from: "June 7, 2025"),
            location: "University of New Brunswick, Fredericton, NB",
            isRemote: false,
            applicationUrl: "https://cwsf.youthscience.ca",
            tags: ["competition", "science fair", "STEM", "youth", "canada", "fredericton", "projects"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Sanofi BioGENEius Challenge Canada (SBCC)",
            type: .competition,
            category: .stem,
            organization: "Sanofi BioGENEius Challenge Canada",
            description: "This national biotechnology competition exposes high school and CEGEP students to career possibilities in the bio-economy. Currently paused for assessment in 2025. Details for the refreshed program will be shared in the coming months.",
            requirements: ["High school and CEGEP students interested in biotechnology"],
            benefits: ["Career exposure in bio-economy", "National recognition"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: nil,
            isRemote: true,
            applicationUrl: "https://biogenius.ca",
            tags: ["competition", "biotechnology", "bioeconomy", "high school", "canada", "paused"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Canadian Open Mathematics Challenge (COMC) 2025",
            type: .competition,
            category: .stem,
            organization: "Canadian Mathematical Society",
            description: "Canada's premier national mathematics challenge, encouraging students to explore and learn more about mathematics and problem-solving. Open to all students with an interest in high school mathematics.",
            requirements: ["Open to all students with an interest in high school mathematics"],
            benefits: ["National recognition", "Certificates", "Problem-solving experience"],
            deadline: nil,
            startDate: dateFormatter.date(from: "October 1, 2024"),
            endDate: dateFormatter.date(from: "October 31, 2024"),
            location: nil,
            isRemote: true,
            applicationUrl: "https://cms.math.ca/Competitions/COMC/",
            tags: ["competition", "mathematics", "challenge", "problem-solving", "canada", "comc"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Canadian Mathematical Olympiad (CMO) 2025",
            type: .competition,
            category: .stem,
            organization: "Canadian Mathematical Society",
            description: "An elite competition for advanced mathematics students, with results and certificates sent to participants. Invitation-only event for top scorers from the COMC and CMOQR.",
            requirements: ["Invitation-only for top scorers from the COMC and CMOQR"],
            benefits: ["Elite recognition", "Certificates", "Advanced math experience"],
            deadline: nil,
            startDate: dateFormatter.date(from: "March 6, 2025"),
            endDate: dateFormatter.date(from: "March 6, 2025"),
            location: nil,
            isRemote: true,
            applicationUrl: "https://cms.math.ca/Competitions/CMO/",
            tags: ["competition", "mathematics", "olympiad", "advanced", "canada", "cmo"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Canadian Innovation Creative Writing Contest (CIWC)",
            type: .competition,
            category: .stem,
            organization: "Competitive Kids Organization",
            description: "A contest that combines innovation with storytelling, encouraging students to explore and express scientific concepts through creative writing. Open to students interested in STEM and creative writing.",
            requirements: ["Open to students interested in STEM and creative writing"],
            benefits: ["Creative writing experience", "STEM exploration", "Recognition"],
            deadline: nil,
            startDate: dateFormatter.date(from: "April 1, 2025"),
            endDate: dateFormatter.date(from: "April 13, 2025"),
            location: nil,
            isRemote: true,
            applicationUrl: "https://cic.competitivekids.org",
            tags: ["competition", "creative writing", "STEM", "innovation", "canada", "ciwc"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "IEOM High School STEM Competition 2025",
            type: .competition,
            category: .stem,
            organization: "IEOM Society International",
            description: "Recognizes outstanding students for their accomplishments in Science, Technology, Engineering, and Mathematics. Students can submit individual and/or team research projects in these fields.",
            requirements: ["High school students with innovative STEM projects"],
            benefits: ["Recognition", "Research project submission", "STEM networking"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: nil,
            isRemote: true,
            applicationUrl: "https://ieomsociety.org/canada/",
            tags: ["competition", "STEM", "high school", "research", "canada", "ieom"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        
        // --- 2025 Canadian Grants & Funding Opportunities ---
        opportunities.append(Opportunity(
            title: "Catapult Canada Access Innovation Fund",
            type: .grant,
            category: .general,
            organization: "Rideau Hall Foundation",
            description: "Supports initiatives addressing barriers to education for youth across Canada. Projects must improve access to learning, especially for equity-deserving youth.",
            requirements: ["Registered charities and incorporated non-profits"],
            benefits: ["Funding: $25,000–$150,000"],
            deadline: dateFormatter.date(from: "June 20, 2025"),
            startDate: nil,
            endDate: nil,
            location: "Canada-wide",
            isRemote: true,
            applicationUrl: "https://catapultcanada.ca",
            tags: ["grant", "education", "youth", "access", "equity", "canada"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Cassels 2025 Grant for Black-Owned Small Businesses",
            type: .grant,
            category: .business,
            organization: "Cassels",
            description: "Provides capital to support the growth of Black-owned small businesses in Canada. $10,000 cash grant.",
            requirements: ["Black-owned Canadian businesses with fewer than 50 employees"],
            benefits: ["$10,000 cash grant"],
            deadline: dateFormatter.date(from: "July 1, 2025"),
            startDate: nil,
            endDate: nil,
            location: "Canada-wide",
            isRemote: true,
            applicationUrl: "https://cassels.com",
            tags: ["grant", "business", "black-owned", "small business", "canada"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "TELUS Friendly Future Foundation Grants",
            type: .grant,
            category: .healthcare,
            organization: "TELUS Friendly Future Foundation",
            description: "Supports local, grassroots health and education programs supporting youth up to age 29. Up to $20,000 for single-year funding.",
            requirements: ["Canadian registered charities and qualified donees"],
            benefits: ["Up to $20,000 grant", "Support for youth well-being and development"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada-wide",
            isRemote: true,
            applicationUrl: "https://friendlyfuture.com/en/foundation/grants/",
            tags: ["grant", "health", "education", "youth", "telus", "canada"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "CIBC Community Investment Funding",
            type: .grant,
            category: .general,
            organization: "CIBC",
            description: "Offers funding across various sectors to support community initiatives. Streams include Financial Education & Inclusion, Youth Empowerment, and Health & Wellness.",
            requirements: ["Canadian registered charities, not-for-profits, or qualified donees with sustainable funding models and measurable impact"],
            benefits: ["Funding for financial education, youth empowerment, health & wellness"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada-wide",
            isRemote: true,
            applicationUrl: "https://cibc.com/en/about-cibc/community-investment.html",
            tags: ["grant", "community", "education", "youth", "health", "wellness", "canada"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Digital Opportunity Trust (DOT) Youth Entrepreneurship Grants",
            type: .grant,
            category: .entrepreneurship,
            organization: "Digital Opportunity Trust",
            description: "Provides grants to support and train youth-led digital and entrepreneurial projects. Focus on women-identifying youth.",
            requirements: ["Youth (often women-identifying) seeking entrepreneurial skills"],
            benefits: ["Support and training grants for youth-led digital and entrepreneurial projects"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada-wide",
            isRemote: true,
            applicationUrl: "https://dotrust.org",
            tags: ["grant", "entrepreneurship", "youth", "digital", "women", "canada"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "TD Friends of the Environment Foundation Grant",
            type: .grant,
            category: .environment,
            organization: "TD Friends of the Environment Foundation",
            description: "Supports grassroots environmental projects like community gardens, green schoolyards, park clean-ups, and outdoor learning initiatives. Most grants range from $2,000–$8,000.",
            requirements: ["Canadian registered charities, municipalities, schools, and Indigenous organizations"],
            benefits: ["$2,000–$8,000 grant", "Support for environmental education, biodiversity, or green infrastructure"],
            deadline: dateFormatter.date(from: "July 15, 2025"),
            startDate: nil,
            endDate: nil,
            location: "Canada-wide",
            isRemote: true,
            applicationUrl: "https://fef.td.com",
            tags: ["grant", "environment", "community", "biodiversity", "canada", "td"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Province-wide Empowerment Grant Program",
            type: .grant,
            category: .communityService,
            organization: "Ontario Power Generation (OPG)",
            description: "Supports initiatives that align with OPG's priority areas: youth empowerment, strong communities, environmental protection, or Indigenous reconciliation. Province-wide: $10,000–$100,000; Regional: $2,000–$25,000.",
            requirements: ["Ontario-based not-for-profits"],
            benefits: ["$2,000–$100,000 grant", "Support for youth empowerment, community, environment, or reconciliation"],
            deadline: dateFormatter.date(from: "June 30, 2025"),
            startDate: nil,
            endDate: nil,
            location: "Ontario",
            isRemote: true,
            applicationUrl: "https://www.opg.com/community/empowerment-fund/",
            tags: ["grant", "empowerment", "community", "environment", "indigenous", "ontario", "opg"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Youth Innovations Test Grant",
            type: .grant,
            category: .communityService,
            organization: "Ontario Trillium Foundation",
            description: "Funds initiatives exploring new ideas, researching key issues, and fostering collective problem-solving. Supports grassroots, youth-led, and youth-adult partnership projects.",
            requirements: ["Youth-led groups, nonprofits, and organizations focusing on youth empowerment"],
            benefits: ["Funding for grassroots, youth-led, and youth-adult partnership projects"],
            deadline: dateFormatter.date(from: "April 9, 2025"),
            startDate: nil,
            endDate: nil,
            location: "Ontario",
            isRemote: true,
            applicationUrl: "https://otf.ca/our-grants/youth-innovations-test-grant",
            tags: ["grant", "youth", "innovation", "community", "ontario", "trillium"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "True Voices Youth Grants",
            type: .grant,
            category: .socialJustice,
            organization: "It Gets Better Canada",
            description: "Supports projects that create inclusive environments for 2SLGBTQ+ students in schools across Canada. Up to $5,000 for youth-led school-based projects.",
            requirements: ["Youth-led school-based projects"],
            benefits: ["Up to $5,000 grant", "Support for 2SLGBTQ+ youth inclusion"],
            deadline: dateFormatter.date(from: "May 12, 2025"),
            startDate: nil,
            endDate: nil,
            location: "Canada-wide",
            isRemote: true,
            applicationUrl: "https://itgetsbettercanada.org/true-voices-youth-grants/",
            tags: ["grant", "2SLGBTQ+", "youth", "inclusion", "schools", "canada"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Canada Legacy Fund",
            type: .grant,
            category: .environment,
            organization: "Sail Training International",
            description: "Supports organizations that provide sail training opportunities to young Canadians, particularly those from disadvantaged backgrounds. $25,000 CAD grant.",
            requirements: ["Organizations delivering youth sail training programs where over 60% of participants are young Canadians"],
            benefits: ["$25,000 grant", "Support for youth sail training programs"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada-wide",
            isRemote: true,
            applicationUrl: "https://sailtraininginternational.org/legacy-fund/",
            tags: ["grant", "sail training", "youth", "canada", "legacy fund"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        
        // --- 2025 Additional Canadian Grants & Awards ---
        opportunities.append(Opportunity(
            title: "Youth Innovations Scale Grant",
            type: .grant,
            category: .communityService,
            organization: "Ontario Trillium Foundation",
            description: "Funds initiatives that explore new ideas, research key issues, and foster collective problem-solving. Supports groups enhancing or expanding existing projects to create a deeper impact or reach more youth.",
            requirements: ["Youth-led groups, nonprofits, and organizations focusing on youth empowerment"],
            benefits: ["Funding for scaling youth empowerment projects"],
            deadline: dateFormatter.date(from: "April 9, 2025"),
            startDate: nil,
            endDate: nil,
            location: "Ontario",
            isRemote: true,
            applicationUrl: "https://otf.ca/our-grants/youth-innovations-scale-grant",
            tags: ["grant", "youth", "innovation", "community", "ontario", "trillium", "scale"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Community Recreation Enhancement Grant",
            type: .grant,
            category: .communityService,
            organization: "City of Red Deer",
            description: "Supports community recreation programs that enhance quality of life. Financial support for not-for-profit organizations delivering recreation initiatives.",
            requirements: ["Not-for-profit organizations in Red Deer, Alberta"],
            benefits: ["Financial support for recreation initiatives"],
            deadline: dateFormatter.date(from: "April 4, 2025"),
            startDate: nil,
            endDate: nil,
            location: "Red Deer, Alberta",
            isRemote: false,
            applicationUrl: "https://reddeer.ca/recreation-and-culture/recreation/grants/community-recreation-enhancement-grant/",
            tags: ["grant", "recreation", "community", "alberta", "red deer"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "ATCO Community Energy Fund",
            type: .grant,
            category: .environment,
            organization: "ATCO",
            description: "Supports solutions, opportunities, and education contributing to a more sustainable, net-zero future. Up to $15,000 for nonprofits, schools, and municipalities in Alberta.",
            requirements: ["Nonprofits, schools, and municipalities in Alberta"],
            benefits: ["Up to $15,000 grant for sustainability and energy projects"],
            deadline: dateFormatter.date(from: "June 30, 2025"),
            startDate: nil,
            endDate: nil,
            location: "Alberta",
            isRemote: false,
            applicationUrl: "https://www.atco.com/en-ca/for-communities/community-investment/community-energy-fund.html",
            tags: ["grant", "energy", "sustainability", "environment", "alberta", "atco"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Fraser Valley Realtors Charitable Foundation Grant",
            type: .grant,
            category: .communityService,
            organization: "Fraser Valley Realtors Charitable Foundation",
            description: "Focused on changing the lives of at-risk youth in the Fraser Valley. One-time grants ranging from $1,000 to $25,000 for charities in Surrey, North Delta, Mission, Abbotsford, City of Langley, Township of Langley, or White Rock.",
            requirements: ["Charities located in Surrey, North Delta, Mission, Abbotsford, City of Langley, Township of Langley, or White Rock"],
            benefits: ["$1,000–$25,000 grant for at-risk youth initiatives"],
            deadline: dateFormatter.date(from: "October 1, 2025"),
            startDate: nil,
            endDate: nil,
            location: "Fraser Valley, BC",
            isRemote: false,
            applicationUrl: "https://fvrcf.ca/grants/",
            tags: ["grant", "youth", "fraser valley", "bc", "charity"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Blue Cross 'Our Built Together' Program Grant",
            type: .grant,
            category: .healthcare,
            organization: "Blue Cross",
            description: "Funding for infrastructure projects that foster active living. Up to $50,000 for organizations in Alberta.",
            requirements: ["Organizations in Alberta"],
            benefits: ["Up to $50,000 grant for active living infrastructure"],
            deadline: dateFormatter.date(from: "May 13, 2025"),
            startDate: nil,
            endDate: nil,
            location: "Alberta",
            isRemote: false,
            applicationUrl: "https://www.ab.bluecross.ca/aboutus/our-built-together.php",
            tags: ["grant", "health", "infrastructure", "active living", "alberta", "blue cross"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Windsor Foundation Grants",
            type: .grant,
            category: .general,
            organization: "Windsor Foundation",
            description: "Supports programs and initiatives in the general community providing services to or benefits for the disadvantaged or vulnerable, and for those physically and intellectually challenged; and creative higher education programs in universities and community colleges in Atlantic Canada.",
            requirements: ["Organizations in New Brunswick, Nova Scotia, and Prince Edward Island"],
            benefits: ["Funding for community and higher education initiatives in Atlantic Canada"],
            deadline: dateFormatter.date(from: "May 12, 2025"),
            startDate: nil,
            endDate: nil,
            location: "Atlantic Canada",
            isRemote: false,
            applicationUrl: "https://windsorfoundation.ca/grants/",
            tags: ["grant", "community", "education", "atlantic canada", "windsor foundation"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        // BDC Young Entrepreneur Award is a competition
        opportunities.append(Opportunity(
            title: "BDC Young Entrepreneur Award",
            type: .competition,
            category: .business,
            organization: "Business Development Bank of Canada (BDC)",
            description: "$100,000 grand prize and a second prize of $25,000 in consulting services. Applicants must submit a short video explaining a turning point their business is facing and the solution that will take their company to the next level.",
            requirements: ["Canadian business owners aged 18 to 35"],
            benefits: ["$100,000 grand prize", "$25,000 in consulting services"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada-wide",
            isRemote: true,
            applicationUrl: "https://www.bdc.ca/en/about/awards/young-entrepreneur-award",
            tags: ["competition", "entrepreneur", "business", "award", "canada", "bdc"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        
        // --- 2025 More Canadian Grants & Funding Opportunities ---
        opportunities.append(Opportunity(
            title: "Canada Service Corps Micro-Grants",
            type: .grant,
            category: .communityService,
            organization: "Government of Canada",
            description: "Supports innovative, youth-led community service projects across Canada. Small cash payments for youth-led community service projects.",
            requirements: ["Youth aged 12–30"],
            benefits: ["Small cash payments for youth-led projects"],
            deadline: dateFormatter.date(from: "July 31, 2025"),
            startDate: nil,
            endDate: nil,
            location: "Canada-wide",
            isRemote: true,
            applicationUrl: "https://canada.ca/en/youth/service-corps.html",
            tags: ["grant", "youth", "community", "service", "canada"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        // TELUS Friendly Future Foundation Grants already present, skip duplicate
        // True Voices Youth Grants already present, skip duplicate
        opportunities.append(Opportunity(
            title: "Canada Post Community Foundation Grants",
            type: .grant,
            category: .communityService,
            organization: "Canada Post",
            description: "Supports community-based support projects for children and youth up to age 21. Funding varies.",
            requirements: ["Schools, charities, and community organizations providing programming to children and youth up to age 21"],
            benefits: ["Funding for community-based support projects"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada-wide",
            isRemote: true,
            applicationUrl: "https://canadapost-postescanada.ca/en/our-company/community-foundation/grants.page",
            tags: ["grant", "community", "youth", "children", "canada post", "canada"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Environmental Damages Fund – Canada",
            type: .grant,
            category: .environment,
            organization: "Environment and Climate Change Canada",
            description: "Supports projects that restore or conserve the environment. Funding varies.",
            requirements: ["Organizations and individuals undertaking environmental restoration or conservation projects"],
            benefits: ["Funding for environmental restoration or conservation"],
            deadline: dateFormatter.date(from: "July 24, 2025"),
            startDate: nil,
            endDate: nil,
            location: "Canada-wide",
            isRemote: true,
            applicationUrl: "https://www.canada.ca/en/environment-climate-change/services/environmental-funding/damages-fund.html",
            tags: ["grant", "environment", "restoration", "conservation", "canada"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "EJ4Climate Grants",
            type: .grant,
            category: .environment,
            organization: "Commission for Environmental Cooperation (CEC)",
            description: "Supports projects that address environmental justice and climate resilience. Up to $175,000 CAD.",
            requirements: ["Organizations working on environmental justice and climate resilience"],
            benefits: ["Up to $175,000 CAD for environmental justice and climate resilience projects"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada-wide",
            isRemote: true,
            applicationUrl: "https://www.cec.org/ej4climate/",
            tags: ["grant", "environment", "climate", "justice", "resilience", "canada", "cec"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Youth Opportunities Fund (YOF)",
            type: .grant,
            category: .communityService,
            organization: "Ontario Trillium Foundation",
            description: "Invests in community-led projects that play an essential role in creating safe spaces, empowering youth and families, supporting career pathways, and addressing issues faced by communities.",
            requirements: ["Community-led projects focusing on youth and families"],
            benefits: ["Funding for community-led youth and family projects"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Ontario",
            isRemote: true,
            applicationUrl: "https://otf.ca/our-grants/youth-opportunities-fund",
            tags: ["grant", "youth", "community", "ontario", "trillium", "YOF"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        opportunities.append(Opportunity(
            title: "Community Development Grants – Jumpstart",
            type: .grant,
            category: .communityService,
            organization: "Canadian Tire Jumpstart Charities",
            description: "Supports organizations delivering sport and physical activity programs for children and youth facing financial or accessibility barriers. Grants range from $1,000 to over $100,000.",
            requirements: ["Organizations delivering sport and physical activity programs for children and youth facing financial or accessibility barriers"],
            benefits: ["$1,000 to $100,000+ for sport and physical activity programs"],
            deadline: nil,
            startDate: nil,
            endDate: nil,
            location: "Canada-wide",
            isRemote: true,
            applicationUrl: "https://jumpstart.canadiantire.ca/pages/grants",
            tags: ["grant", "community", "youth", "sport", "accessibility", "jumpstart", "canada"],
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        ))
        
        return opportunities
    }
} 