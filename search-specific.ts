import ZAI from 'z-ai-web-dev-sdk';

async function searchSpecific() {
  try {
    console.log('Searching for specific website information...');
    
    const zai = await ZAI.create();
    
    // Try different search queries
    const queries = [
      "mag.pasteuramicale.com",
      "pasteuramicale magazine",
      "site mag.pasteuramicale.com",
      "pasteuramicale association magazine"
    ];
    
    for (const query of queries) {
      console.log(`\nSearching for: "${query}"`);
      const searchResult = await zai.functions.invoke("web_search", {
        query: query,
        num: 5
      });
      
      console.log('Results found:', searchResult.length);
      searchResult.forEach((result: any, index: number) => {
        console.log(`${index + 1}. ${result.name} - ${result.url}`);
        console.log(`   ${result.snippet}`);
      });
    }
    
  } catch (error: any) {
    console.error('Error:', error.message);
  }
}

searchSpecific();