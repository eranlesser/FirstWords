package
{
	import com.levels.Level;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class App extends Sprite
	{
		[Embed(source="assets/bg.png")]
		private  const bg:Class;
		public function App(){
			addChild(new Image(Texture.fromBitmap(new bg())))
			addChild(new Level());
		}
	}
}