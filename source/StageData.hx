package;

#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import openfl.utils.Assets;
import Song;
import haxe.Json;
import haxe.format.JsonParser;

using StringTools;

typedef StageFile =
{
	var directory:String;
	var defaultZoom:Float;
	var defaultExtend:Float;
	var isPixelStage:Bool;

	var boyfriend:Array<Dynamic>;
	var girlfriend:Array<Dynamic>;
	var opponent:Array<Dynamic>;
}

class StageData
{
	public static var forceNextDirectory:String = null;

	public static function loadDirectory(SONG:SwagSong)
	{
		var stage:String = '';
		if (SONG.stage != null)
		{
			stage = SONG.stage;
		}
		else
		{
			stage = 'stage';
		}

		var stageFile:StageFile = getStageFile(stage);
		if (stageFile == null)
		{ // preventing crashes
			forceNextDirectory = '';
		}
		else
		{
			forceNextDirectory = stageFile.directory;
		}
	}

	public static function getStageFile(stage:String):StageFile
	{
		var rawJson:String = null;
		var path:String = Paths.getPreloadPath('stages/' + stage + '.json');

		#if MODS_ALLOWED
		var modPath:String = Paths.modFolders('stages/' + stage + '.json');
		if (FileSystem.exists(modPath))
		{
			rawJson = File.getContent(modPath);
		}
		#end
		if (Assets.exists(path))
		{
			rawJson = Assets.getText(path);
		}
	else
	{
		return null;
	}
		return cast Json.parse(rawJson);
	}
}
