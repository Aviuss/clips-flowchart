import tkinter as tk
from clips import Environment

class ExpertSystemGUI:
    def __init__(self, root, environment):
        self.root = root
        self.env = environment
        self.root.geometry("600x400")
        self.root.title("Instrument Expert System")
        
        self.label = tk.Label(root, text="", font=("Arial", 10), wraplength=400)
        self.label.pack(pady=20)
        
        self.button_frame = tk.Frame(root)
        self.button_frame.pack(pady=10, padx=20, fill="both", expand=True)
        
        self.history = []
        self.current_question = None
        
        self.display_next()
    
    def display_next(self):
        for widget in self.button_frame.winfo_children():
            widget.destroy()
        
        self.question_fact = None
        instrument_fact = None
        
        for fact in self.env.facts():
            if fact.template.name == "pytanie":
                self.question_fact = fact
                break
            elif fact.template.name == "instrument":
                instrument_fact = fact
                break

        if instrument_fact:
            instrument_name = str(instrument_fact[0])
            self.label.config(text=f"Recommended instrument \n\n {instrument_name}")
            tk.Button(self.button_frame, text="Once Again", 
                     font=("Arial", 10),
                     command=self.restart).pack(pady=5)
            tk.Button(self.button_frame, text="Show History", 
                     font=("Arial", 10),
                     command=self.show_history).pack(pady=5)
        elif self.question_fact:
            question_text = self.question_fact["tresc"]
            options = list(self.question_fact["opcje"])
            
            self.current_question = question_text
            self.label.config(text=question_text)
            
            for option in options:
                button = tk.Button(self.button_frame, 
                               text=option,
                               font=("Arial", 10),
                               wraplength=400,
                               justify="center",
                               padx=10,
                               pady=8,
                               command=lambda opt=option: self.submit(opt))
                button.pack(pady=3, fill="x", padx=20)
    
    def submit(self, answer):
        self.history.append((self.label["text"], answer))
        
        if self.question_fact:
            self.question_fact.retract()    
        
        self.env.assert_string(f'(odpowiedz_do_pytania (tresc "{self.current_question}") (odpowiedz "{answer}"))')
        self.env.run()
        self.display_next()
    
    def restart(self):
        self.history.clear()
        self.env.reset()
        self.env.run()
        self.display_next()
    
    def show_history(self):
        window = tk.Toplevel(self.root)
        window.title("History")
        window.geometry("600x400")
        
        text_widget = tk.Text(window, wrap="word", font=("Arial", 10))
        text_widget.pack(expand=True, fill="both", padx=10, pady=10)
        
        for question, answer in self.history:
            text_widget.insert("end", f"Q: {question}\nA: {answer}\n\n")

if __name__ == "__main__":
    env = Environment()
    env.load("clips.clp")
    env.reset()
    env.run()
    
    root = tk.Tk()
    gui = ExpertSystemGUI(root, env)
    root.mainloop()