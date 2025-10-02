package;

import backend.Converter;
import haxe.Log;
import haxe.Json;
import sys.io.File;

class ConverterMain
{
    static function print(msg:Dynamic)
    {
        Log.trace(msg, null);
    }

    static function main()
    {
        if (Sys.args().length < 1)
        {
            print('Brainality Engine Character Convertor CLI v1.0');
            return;
        }

        var engine:String = 'Psych';
        var input:String = null;
        var output:String = 'out/character.json';

        var args = Sys.args();
        var i = 0;

        while (i < args.length)
        {
            switch(args[i])
            {
                case '--input', '--in', '-i':
                    if (i + 1 < args.length)
                    {
                        input = args[i + 1];
                        i++;
                    }
                    else
                    {
                        print('ERROR: --input requires a value!');
                        return;
                    }

                case '--engine', '-e':
                    if (i + 1 < args.length)
                    {
                        engine = args[i + 1];
                        i++;
                    }
                    else
                    {
                        print('ERROR: --engine requires a value!');
                        return;
                    }

                case '--output', '-o':
                    if (i + 1 < args.length)
                    {
                        output = args[i + 1];
                        i++;
                    }
                    else
                    {
                        print('ERROR: --output requires a value!');
                        return;
                    }

                default:
                    print('Unknown argument: ' + args[i]);
            }
            i++;
        }

        if (input == null)
        {
            print('ERROR: Input field required!');
            return;
        }

        var converted = Converter.character(input);

        // Save to JSON file
        try {
            var jsonStr = Json.stringify(converted, null, "\t"); // optional pretty-print
            File.saveContent(output, jsonStr);
            print('Conversion complete! Saved to ' + output);
        } catch (e:Dynamic) {
            print('ERROR: Failed to save file - ' + e);
        }
    }
}
