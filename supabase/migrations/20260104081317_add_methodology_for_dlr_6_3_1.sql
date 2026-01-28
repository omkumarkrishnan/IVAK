/*
  # Add Verification Methodology for DLR 6.3.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 6.3.1 (Internet connectivity pilot completed by ITD in one district based on feasibility study findings)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Report on Pilot Study
    - B. Desk Review of Report on internet connectivity
    - C. Desk Review of Report on Users Accessing Internet Connectivity
    - D. Field Review
    
  3. Changes
    - Update methodology field for all verifications under DLR 6.3.1
*/

-- Update methodology for DLR 6.3.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of Report on Pilot Study

The IVA will verify the following aspects:

a. Verify the authorized signature of the Nodal Officer Report
b. Verify that the content of the report includes:
   (i) baseline internet connectivity situation in the concerned district
   (ii) the technology options implemented
   (iii) details on additional internet access created for women and youth (18-35)
   (iv) any quality improvements in internet connectivity
   (v) the cost of internet access
   (vi) compliance with feasibility report
   (vii) compliance with detailed project report
   (viii) compliance with the contract signed with the vendor implementing the connectivity option
   (ix) Best practices which can be recommended for other districts.
c. Verify the completion certificate issued to the vendor implementing the connectivity option.

Connectivity Pilot study will be in one of these five districts - Gangtok, Mangan, Namchi, Gyalshing, Pakyong

B. Desk Review of Report on internet connectivity

The IVA will verify the following aspects based on the data on internet connectivity details for the concerned district available from the reports:

a. Number of GPUs with Internet connectivity
b. Technology Options (OFC/Non-OFC/Mixed) available
c. Number of Households with Internet Connectivity
d. Number of Govt. offices with Internet Connectivity
e. Number of Educational Institutes with Internet Connectivity
f. Number of Private Organizations with Internet Connectivity
g. Number of Health Centers with Internet Connectivity
h. Date since Internet access was available (GPU) with Internet Connectivity

C. Desk Review of Report on Users Accessing Internet Connectivity

The IVA will verify the following aspects from data on users accessing internet connectivity in the concerned district with the available reports:

a. Number of Registered Users accessing Internet (Gender and Youth disaggregated)
b. Number of Gram Panchayat Unit with internet connectivity
c. No. of Women accessing Internet
d. No. of Youth (18-35) accessing internet
e. Date since Internet access was available at GPU
f. Date since Internet access was available for User
g. Available Technology options (OFC/Non-OFC/Mixed)
h. Download Speed (KBPS)
i. Upload Speed (KBPS)
j. Latency (Seconds)
k. Reliability (Score)

D. Field Review

The IVA will carry out field verification on a random sample of users across 20 percent of the Gram Panchayat Units in the district. The IVA will verify the following aspects based on a stratified random sample of 20 percentage of internet users:

a. Name of Registered Internet User using Internet
b. No. of Women users
c. No. of Youth (18-35) users
d. Technology options (OFC/Non-OFC/Mixed)
e. Download Speed (KBPS)
f. Upload Speed (KBPS)
g. Latency (Seconds)
h. Reliability (Score)
i. Packet loss
j. Number of days'' downtime since implementation
k. Number of days'' uptime
l. Any challenges faced

Five GPUs are randomly selected from the list of GPUs in the concerned district.'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 6.3.1');
