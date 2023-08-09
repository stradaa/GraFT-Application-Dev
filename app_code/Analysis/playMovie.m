function playMovie(a)
%PLAYMOVIE 

num = numel(a.Status.active_movies);

if a.Status.max_m_frame == a.Status.m_frame
    a.Status.m_frame = 1;
end

switch num
    case 1
        temp1 = eval(a.Status.active_movies(1));
        for i = a.Status.m_frame:a.Status.max_m_frame
            imagesc(a.UIAxes3_2, temp1(:,:,i));
            pause(1/a.fpsEditField.Value);
            a.Status.m_frame = i;
            a.Slider.Value = i;
            if a.Status.m_stop
                return
            end
        end

    case 2
        temp1 = eval(a.Status.active_movies(1));
        temp2 = eval(a.Status.active_movies(2));
        for i = a.Status.m_frame:a.Status.max_m_frame
            imagesc(a.UIAxes3, temp1(:,:,i));
            imagesc(a.UIAxes3_2, temp2(:,:,i));
            pause(1/a.fpsEditField.Value);
            a.Status.m_frame = i;
            a.Slider.Value = i;
            if a.Status.m_stop
                return
            end
        end
    case 3
        temp1 = eval(a.Status.active_movies(1));
        temp2 = eval(a.Status.active_movies(2));
        temp3 = eval(a.Status.active_movies(3));
        for i = a.Status.m_frame:a.Status.max_m_frame
            imagesc(a.UIAxes3, temp1(:,:,i));
            imagesc(a.UIAxes3_2, temp2(:,:,i));
            imagesc(a.UIAxes3_3, temp3(:,:,i));
            pause(1/a.fpsEditField.Value);
            a.Status.m_frame = i;
            a.Slider.Value = i;
            if a.Status.m_stop
                return
            end
        end
end

end

