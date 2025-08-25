import ZAI from 'z-ai-web-dev-sdk';

async function testSearch() {
  try {
    console.log('Testing ZAI SDK...');
    
    // Try different ways to initialize
    const zai = await ZAI.create();
    console.log('ZAI created successfully');
    
    const searchResult = await zai.functions.invoke("web_search", {
      query: "mag.pasteuramicale.com site information",
      num: 10
    });
    
    console.log('Search Results:', JSON.stringify(searchResult, null, 2));
  } catch (error: any) {
    console.error('Error:', error.message);
    console.error('Stack:', error.stack);
  }
}

testSearch();