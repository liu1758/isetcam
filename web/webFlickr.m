classdef webFlickr
    %WEBFLICKER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        api_key;
        search_url;
        format;
        nojsoncallback;
        per_page;
        licenses;
    end
    
    methods
        function obj = webFlickr()
            %WEBFLICKER Construct an instance of this class
            %   Detailed explanation goes here
            obj.api_key = 'a6365f14201cd3c5f34678e671b9ab8d'; % use mine for now at least
            obj.search_url = 'https://www.flickr.com/services/rest/?method=flickr.photos.search';
            obj.format = 'json';
            obj.nojsoncallback = '1';
            obj.per_page = 50; %our default of how many photos we want
            obj.licenses = '1,2,3,4,5,6,7,8,9,10'; % everything shareable for now
            %obj.api_key = inputArg1;
        end
        
        function outputArg = search(obj,ourTags)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = webread(obj.search_url, 'api_key', obj.api_key, 'tags', ourTags, ...
            'format', obj.format, 'nojsoncallback', obj.nojsoncallback, 'safe_search', 1, ...
            'content_type', 1, 'per_page', obj.per_page, 'license', obj.licenses);            
        end
        
        % pass a Flickr photo object and desired size to get the URL of the
        % image
        %https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
        function ourURL = getImageURL(obj, fPhoto, wantSize)
            if isequal(wantSize, 'thumbnail')
                sizeSuffix = 't'; % 100 px longest side is t
            else
                sizeSuffix = 'b'; % 1024 px for now
            end 
            ourURL = strcat("https://farm", string(fPhoto.farm), ".staticflickr.com/", string(fPhoto.server) + "/", ...
                string(fPhoto.id), "_" + string(fPhoto.secret), "_" + string(sizeSuffix), ".jpg");
        end
        
        function ourImage = getImage(obj, fPhoto, wantSize)
            ourURL = getImageURL(obj, fPhoto, wantSize);
            ourImage = webread(ourURL);   
        end
    end
end

