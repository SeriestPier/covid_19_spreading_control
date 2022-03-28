function print_plot(t,X)
%% Variables
    global Lvect
    title_name = {'S' 'E' 'P' 'I' 'A' 'H' 'Q' 'R' 'D'};     %Labels
    pos = [3 4 5 8 9 10 13 14 15];                          %Position of each subplot
    cmap = hsv(9);                                          %Colour Map
    
%% Plot Building

    figure

    subplot(4,5,[1 2 6 7 11 12]);                           %Total Plot
    imp_var = [X(:,1) X(:,4) X(:,5) X(:,9) X(:,13) X(:,16) X(:,19) X(:,20) X(:,21)];
    
    for k = 1:9
        line(t, imp_var(:,k:9), 'Color', cmap(k, :));
    end

    grid on;
    title('Covid-19 Model'); xlabel('Time (days)'); ylabel('Population (%)');

    %Plotting each variable
    for i=1:9
        subplot (4,5,pos(i))
        plot (t,imp_var(:,i),'Color',cmap(i,:));
        grid on;
        title (title_name{i});
    end
    
    %Lockdown Intensity Plot
    subplot(4,5,(16:20));
    bar(Lvect', 'b');
    title ('Lockdown Intensity');
end
