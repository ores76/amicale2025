import ZAI from 'z-ai-web-dev-sdk';

async function searchAmicale() {
  try {
    console.log('Searching for amicale and school magazine information...');
    
    const zai = await ZAI.create();
    
    // Try searching for amicale school magazines in France
    const queries = [
      "amicale magazine scolaire France",
      "site association amicale magazine",
      "journal amicale école France",
      "site web magazine association scolaire"
    ];
    
    for (const query of queries) {
      console.log(`\nSearching for: "${query}"`);
      const searchResult = await zai.functions.invoke("web_search", {
        query: query,
        num: 3
      });
      
      console.log('Results found:', searchResult.length);
      searchResult.forEach((result: any, index: number) => {
        console.log(`${index + 1}. ${result.name}`);
        console.log(`   URL: ${result.url}`);
        console.log(`   ${result.snippet}`);
      });
    }
    
  } catch (error: any) {
    console.error('Error:', error.message);
  }
}

searchAmicale();